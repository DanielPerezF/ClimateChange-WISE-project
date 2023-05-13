from gams.transfer import Container
import pandas as pd
import numpy as np

def read_gdx(path_gdx: str,vars,initial_year=2015,tstep=5):
    """Read the gdx
    path_gdx: path to file .gdx
    var: str of variable to read
    initial_year: start of model
    tstep of model (years)

    Returns dataframe
    """
    gdx = Container(path_gdx)

    df = gdx[vars[0]].records.drop(columns=['marginal','lower','upper','scale'])
    df.rename(columns={'level':vars[0]},inplace=True)
    for i,var in enumerate(vars):
        if i != 0:
            df[var] = gdx[var].records['level']

    df = df.rename(columns={'t_0':'t','n_1':'region'})
    df['t'] = df['t'].astype('int')
    df['year'] = initial_year + tstep*(df['t']-1)
    df['region'] = df['region'].astype(str)
    return df

def read_scenarios(paths,vars,initial_year=2015,tstep=5):
    df_old = pd.DataFrame()

    for path in paths:
        df_new = read_gdx(path,vars,initial_year,tstep)
        df_new['scen'] = path.split('/')[-1].replace("results_",'').replace('.gdx','').replace('approach_','')
        df_old = pd.concat([df_old,df_new])
        
    return df_old

def calc_cum_emis(data,final_y=2100):
    cum_emis = pd.DataFrame()

    for scen in data['scen'].unique():
        df_scen = data[(data['scen'] == scen) & (data['year'] <= final_y)]
        cum_emis_scen = df_scen.pivot_table('E','year','region').cumsum().reset_index()
        cum_emis_scen = pd.melt(cum_emis_scen,id_vars=['year'],value_name='CUMEMI')
        cum_emis_scen['scen'] = scen
        cum_emis = pd.concat([cum_emis,cum_emis_scen])
    return cum_emis

def gini(array):
    """Calculate the Gini coefficient of a numpy array."""
    # based on bottom eq:
    # http://www.statsdirect.com/help/generatedimages/equations/equation154.svg
    # from:
    # http://www.statsdirect.com/help/default.htm#nonparametric_methods/gini.htm
    # All values are treated equally, arrays must be 1d:
    # array = array.flatten()
    if np.amin(array) < 0:
        # Values cannot be negative:
        array -= np.amin(array)
    # Values cannot be 0:
    array = array + 0.0000001
    # Values must be sorted:
    array = np.sort(array)
    # Index per array element:
    index = np.arange(1,array.shape[0]+1)
    # Number of array elements:
    n = array.shape[0]
    # Gini coefficient:
    return ((np.sum((2 * index - n  - 1) * array)) / (n * np.sum(array)))