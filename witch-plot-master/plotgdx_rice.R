rm(list = ls())
witch_folder = "C:/Users/danip/Documents/GitHub/ClimateChange-WISE-project" #Where you're RICE/DICE/RICE50x code is located
#main directory of your results files
main_directory <- witch_folder # by default, the witch source folder
subdir = c("results") #can be multiple directories

region_id = "r5" #for historical data folder
year0 = 2015
tstep = 5

restrict_files = c("") #to all scenarios matching partly one of its arguments
exclude_files = c("")
removepattern = c("results_")

yearmin = 1980
yearmax = 2300

#Initialize default options, load all witch and other functionsget
source('R/witch_functions.R')

#mapping of variables to historical and validation statistics and unit conversion to WITCH units
map_var_hist <- fread("varname_model, set_model, element_model, var_witch, set_witch, element_witch, conv
Y, , , SOCECON, *, gdp-ppp, 1
E, , , Q_EMI, e, co2, 0.2727273
pop, , , l, , , 1e-3
K, , , K, g, fg, 1
I, , , I, g, fg, 1
")

#gdxcompaR(Standard gdxcompaR based on typical variables, otherwise edit in gdxcompaR/server.R)
runApp(appDir = "gdxcompaR/rice")

get_witch_variable("E")
get_witch_simple("Y")
