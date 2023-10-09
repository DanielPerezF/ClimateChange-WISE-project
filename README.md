# ClimateChange-WISE-project
Group WISE (group 8) for the Climate Change and Energy Modeling course.
Project on the relation between carbon budget effort sharing approaches and regional inequalities studying climate change. 

## Description
The project consisted on studying the effect of different carbon budget sharing approaches on regional inequalities (a 1000 $G_{ton,CO2}$ budget was used compliant with a 1.5°C temperature rise). The RICE model was used in GAMS.
Different inequality aversion ($\gamma$) values were used in order to compare this effect with the different approaches. Among these there were:
- Grandfathering: countries that emit more now have to pay less for carbon mitigation.
- Ability to pay: countries with higher GDP per capita have to pay more for mitigation.
- Historical emissions: countries that have emitted more in the past pay more for mitigation.
- Per capita: countries with bigger populations pay more for mitigation.

## Main findings
The following graphs show the regional distribution of the assigned carbon budget and the mitigation costs accross the different scenarios:
<img src="https://github.com/DanielPerezF/ClimateChange-WISE-project/assets/118309576/0e436a04-1deb-43f3-86d4-3de7d86fa011" width="52%"> 
<img src="https://github.com/DanielPerezF/ClimateChange-WISE-project/assets/118309576/fe6e9076-e385-4f10-904b-4b8895338625" width="47%">

And the following graphs show the global cost of mitigation accross the different scenarios and the top 10 countries that emit the most:
<img src="https://github.com/DanielPerezF/ClimateChange-WISE-project/assets/118309576/daff05f1-29a7-449b-98ba-ae5db389e1f1" width="43%">
<img src="https://github.com/DanielPerezF/ClimateChange-WISE-project/assets/118309576/e52eafb9-115d-4098-a4e5-4c2e2223200a" width="43%">

In general, different scenarios may end up with a more efficient (lower cost) way of distributing the global carbon budget, however, this might be at the expense of a bigger effort by other countries. Most importantly, a more efficient approach may distribute the budget based on reasons that some may not consider ethical, and there is no right or wrong answer. 

## Files used
The python notebook regional_data.ipynb is used for ingesting, processing and saving the data used for creating the shares going to each region. For projected populations and GDPs, as well as initial emissions, we used the data_baseline.gdx file inside of each of the data folders (data_r5, data_witch17, data_ed57). Regarding historical emissions we used data from the Global Carbon project that can be found in the owid-co2-data.csv file.
With this data we calculated the shares of global emissions that correspond to each region under the different apporaches and SSPs. The resultant shares are saved to each of the data folders (data_r5, data_witch17, data_ed57) as effort_shares.gdx.

The shares are loaded into RICE in the core_policy.gms file. According to the flags used when running the approach and SSP to be used can be specified. 

The python notebook exploratory.ipynb is used for loading the results from modeling, processing them and generating the plots.

The R notebook map_plotting.Rmd can be used for generating maps. This file uses the csv files mapr5.csv, mapwitch17.csv and maped57.csv, depending on the region definition used.
