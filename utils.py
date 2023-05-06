from gams.transfer import Container
import pandas as pd

def read_gdx(path_gdx: str,vars,initial_year=2010,tstep=5):
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

    df['t_0'] = df['t_0'].astype('int')
    df['year'] = initial_year + tstep*(df['t_0']-1)
    if 'n_1' in df.columns:
        df['n_1'] = df['n_1'].astype(str)
        df.rename(columns={'n_1':'region'},inplace=True)
    return df

def read_scenarios(paths,vars,initial_year=2010,tstep=5):
    df_old = pd.DataFrame()

    for path in paths:
        df_new = read_gdx(path,vars,initial_year,tstep)
        df_new['scen'] = path.replace("results/results_","").replace(".gdx","")
        df_old = pd.concat([df_old,df_new])
        
    return df_old