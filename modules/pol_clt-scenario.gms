* POLICY: Coalitions scenarios
* -------------------------------
* Define coalitions settings here and assign a referencing [scenario_id].
* Special cases of coalitions run mode. 
*

#=========================================================================
*   ///////////////////////       SETTING      ///////////////////////
#=========================================================================


##  CONF
#_________________________________________________________________________
$ifthen.ph %phase%=='conf'


* Check scenario is set
$if not set scenario_id $abort 'USER ERROR: [scenario_id] flag not defined by user!'
* Optimization mode
$setglobal run_mode 'optimization'
$if not %run_mode%=='optimization' $abort 'USER ERROR: [run_mode] must be -optimization- for CLT-SCENARIO policy!'
* Check coalitions cooperation mode
$ifi not %cooperation%=="coalitions" $abort 'USER ERROR: [cooperation] must be -coalitions- for CLT-SCENARIO policy!'



## SETS
#_________________________________________________________________________
$elseif.ph %phase%=='sets'


# ==== EU ========

$ifthen.cltscen %scenario_id%=="cneutral-eu"

# Mapping set declaring which coalitions are active for eac time period
* It can be overwritten in policy file using
SET map_t_clt(t,clt) "Mapping set between time and active coalitions" /
(1*58).(eu27, chn, jpn, usa, gbr, arg, aus, bra, can,  chl, cor, egy, golf57, idn, meme, mex, mys, nde, noan, noap, nor, osea, rcam, ris, rjan57, rsaf, rsam, rsas, rus, sui, tha, tur, ukr,  vnm, zaf, oeu)
/;
# Each coalition-changing time period in map_t_clt mapping
# must be added in this flag sequence
$setglobal coalitions_t_sequence 1
$onMulti


# ==== EU + CHN ========

$elseif.cltscen  %scenario_id%=="cneutral-eu-chn"
$onMulti
SET clt "List of all possibly-applied coalitions" /
eu27_chn
/;
SET map_clt_n(clt,n) "Mapping set between coalitions and belonging regions" /
eu27_chn.(chn, aut, bel, bgr, cro, dnk, esp, fin, fra, grc, hun, irl, ita, nld, pol, prt, rcz, rfa, rom, rsl, slo, swe, blt)
/;
$offMulti
SET map_t_clt(t,clt) "Mapping set between time and active coalitions" /
(1*58).(eu27_chn, jpn, usa, gbr, arg, aus, bra, can,  chl, cor, egy, golf57, idn, meme, mex, mys, nde, noan, noap, nor, osea, rcam, ris, rjan57, rsaf, rsam, rsas, rus, sui, tha, tur, ukr,  vnm, zaf, oeu)
/;
* Coalition-changing time period in map_t_clt mapping
$setglobal coalitions_t_sequence 1
$onMulti


# ==== EU + CHN + JPN ========

$elseif.cltscen  %scenario_id%=="cneutral-eu-chn-jpn"
$onMulti
SET clt "List of all possibly-applied coalitions" /
eu27_chn_jpn
/;
SET map_clt_n(clt,n) "Mapping set between coalitions and belonging regions" /
eu27_chn_jpn.(chn, jpn, aut, bel, bgr, cro, dnk, esp, fin, fra, grc, hun, irl, ita, nld, pol, prt, rcz, rfa, rom, rsl, slo, swe, blt)
/;
$offMulti
SET map_t_clt(t,clt) "Mapping set between time and active coalitions" /
(1*58).(eu27_chn_jpn, usa, gbr, arg, aus, bra, can,  chl, cor, egy, golf57, idn, meme, mex, mys, nde, noan, noap, nor, osea, rcam, ris, rjan57, rsaf, rsam, rsas, rus, sui, tha, tur, ukr,  vnm, zaf, oeu)
/;
* Each coalition-changing time period in map_t_clt mapping
$setglobal coalitions_t_sequence 1
$onMulti


# ==== EU + CHN + JPN + USA ========

$elseif.cltscen  %scenario_id%=="cneutral-eu-chn-jpn-usa"
$onMulti
SET clt "List of all possibly-applied coalitions" /
eu27_chn_jpn_usa
/;
SET map_clt_n(clt,n) "Mapping set between coalitions and belonging regions" /
eu27_chn_jpn_usa.(chn, jpn, usa, aut, bel, bgr, cro, dnk, esp, fin, fra, grc, hun, irl, ita, nld, pol, prt, rcz, rfa, rom, rsl, slo, swe, blt)
/;
$offMulti
SET map_t_clt(t,clt) "Mapping set between time and active coalitions" /
(1*58).(eu27_chn_jpn_usa, gbr, arg, aus, bra, can,  chl, cor, egy, golf57, idn, meme, mex, mys, nde, noan, noap, nor, osea, rcam, ris, rjan57, rsaf, rsam, rsas, rus, sui, tha, tur, ukr,  vnm, zaf, oeu)
/;
* Each coalition-changing time period in map_t_clt mapping
$setglobal coalitions_t_sequence 1
$onMulti


# ==== EU + CHN + JPN + USA + KOR ========

$elseif.cltscen  %scenario_id%=="cneutral-eu-chn-jpn-usa-kor"
$onMulti
SET clt "List of all possibly-applied coalitions" /
eu27_chn_jpn_usa_kor
/;
SET map_clt_n(clt,n) "Mapping set between coalitions and belonging regions" /
eu27_chn_jpn_usa_kor.(chn, cor, jpn, usa, aut, bel, bgr, cro, dnk, esp, fin, fra, grc, hun, irl, ita, nld, pol, prt, rcz, rfa, rom, rsl, slo, swe, blt)
/;
$offMulti
SET map_t_clt(t,clt) "Mapping set between time and active coalitions" /
(1*58).(eu27_chn_jpn_usa_kor, gbr, arg, aus, bra, can,  chl, egy, golf57, idn, meme, mex, mys, nde, noan, noap, nor, osea, rcam, ris, rjan57, rsaf, rsam, rsas, rus, sui, tha, tur, ukr,  vnm, zaf, oeu)
/;
* Each coalition-changing time period in map_t_clt mapping
$setglobal coalitions_t_sequence 1
$onMulti




$endif.cltscen




##  COMPUTE VARIABLES
#_________________________________________________________________________
$elseif.ph %phase%=='compute_vars'


# ==== EU ========

$ifthen.cltscen %scenario_id%=="cneutral-eu"

 EIND.up(t,n)$(eu27(n) and (year(t) ge 2050)) = 0;


# ==== EU + CHN ========

$elseif.cltscen  %scenario_id%=="cneutral-eu-chn"
 EIND.up(t,n)$(eu27(n) and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'chn') and (year(t) ge 2060)) = 0;


# ==== EU + CHN + JPN ========

$elseif.cltscen  %scenario_id%=="cneutral-eu-chn-jpn"
 EIND.up(t,n)$(eu27(n) and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'jpn') and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'chn') and (year(t) ge 2060)) = 0;


# ==== EU + CHN + JPN + USA ========

$elseif.cltscen  %scenario_id%=="cneutral-eu-chn-jpn-usa"
 EIND.up(t,n)$(eu27(n) and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'jpn') and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'usa') and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'chn') and (year(t) ge 2060)) = 0;


# ==== EU + CHN + JPN + USA + KOR ========

$elseif.cltscen  %scenario_id%=="cneutral-eu-chn-jpn-usa-kor"
 EIND.up(t,n)$(eu27(n) and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'jpn') and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'usa') and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'cor') and (year(t) ge 2050)) = 0;
 EIND.up(t,n)$(sameas(n,'chn') and (year(t) ge 2060)) = 0;



$endif.cltscen





$endif.ph