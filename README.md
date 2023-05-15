# ClimateChange-WISE-project
Group WISE (group 8) for the Climate Change and Energy Modeling course.
Project on the relation between carbon budget effort sharing approaches and regional inequalities studying climate change. 

The python notebook regional_data.ipynb is used for ingesting, processing and saving the data used for creating the shares going to each region. For projected populations and GDPs, as well as initial emissions, we used the data_baseline.gdx file inside of each of the data folders (data_r5, data_witch17, data_ed57). Regarding historical emissions we used data from the Global Carbon project that can be found in the owid-co2-data.csv file.
With this data we calculated the shares of global emissions that correspond to each region under the different apporaches and SSPs. The resultant shares are saved to each of the data folders (data_r5, data_witch17, data_ed57) as effort_shares.gdx.

The shares are loaded into RICE in the core_policy.gms file. According to the flags used when running the approach and SSP to be used can be specified. 

The python notebook exploratory.ipynb is used for loading the results from modeling, processing them and generating the plots.

The R notebook map_plotting.Rmd can be used for generating maps. This file uses the csv files mapr5.csv, mapwitch17.csv and maped57.csv, depending on the region definition used.
