@ECHO OFF
cd C:/Users/danip/Documents/GitHub/ClimateChange-WISE-project
ECHO Run all scenarios
gams run_rice50x.gms --n=r5 --impact=off --cooperation=coop --policy=cea-cbudget --sharing=yes --approach=percapita --t_min_miu=7 --t_max_miu=17 --max_miuup=2.5 --cbudget=1000 --baseline=ssp2 --gamma=0 --nameout=gamma0_r5_test
gams run_rice50x.gms --n=r5 --impact=off --cooperation=coop --policy=cea-cbudget --sharing=yes --approach=percapita --t_min_miu=7 --t_max_miu=17 --max_miuup=2.5 --cbudget=1000 --baseline=ssp2 --gamma=0.5 --nameout=gamma0.5_r5_test
gams run_rice50x.gms --n=r5 --impact=off --cooperation=coop --policy=cea-cbudget --sharing=yes --approach=percapita --t_min_miu=7 --t_max_miu=17 --max_miuup=2.5 --cbudget=1000 --baseline=ssp2 --gamma=1.2 --nameout=gamma1.2_r5_test
EXIT /B %ERRORLEVEL%