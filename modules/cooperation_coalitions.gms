* COOPERATION COALITIONS
* Define coalitions mappings
#=========================================================================
*   ///////////////////////       SETTING      ///////////////////////
#=========================================================================
##  CONF
#_________________________________________________________________________
$ifthen.ph %phase%=='conf'

$if not %n%=="ed57" $abort 'ERROR: cooperation_coalitions require n mapping is ed57'

# This is to be sure to initialize the sequence
$setglobal coalitions_t_sequence 1

$setglobal solmode 'noncoop'

## REGION WEIGHTS
* Force correct setting for noncoop and disentagled mode
$setglobal region_weights '%weighting%'
$if set disentangled         $setglobal region_weights 'pop'

* Negishi weights
$iftheni.rw  %weighting% == 'negishi'
$setglobal calc_nweights ((CPC.l(t,n)**elasmu)/sum(nn, (CPC.l(t,nn)**(elasmu))))
$setglobal region_weights 'ngsw'
$else.rw

* Population weights
$setglobal calc_nweights 1
$setglobal region_weights 'pop'
$endif.rw

* Set name for temporary partial solution dumps 
* (essential for time-varying coalitions)
$setglobal gdxfix "%temppath%/%nameout%_gdxfix"



## SETS
#_________________________________________________________________________
$elseif.ph %phase%=='sets'

* Some pre-defined coalitions
* in a policy file this set can be extended with new coalitions
SET clt "List of all possibly-applied coalitions" /
# Single-region coalitions
$include %datapath%n.inc
# European Union
eu27
# Grand coalition (all)
grand

/;

* Some pre-defined coalitions mapping
* in a policy file this set can be extended with new coalitions
SET map_clt_n(clt,n) "Mapping set between coalitions and belonging regions" /
# Single-region coalition
arg.arg
aus.aus
aut.aut
bel.bel
bgr.bgr
blt.blt
bra.bra
can.can
chl.chl
chn.chn
cor.cor
cro.cro
dnk.dnk
egy.egy
esp.esp
fin.fin
fra.fra
gbr.gbr
golf57.golf57
grc.grc
hun.hun
idn.idn
irl.irl
ita.ita
jpn.jpn
meme.meme
mex.mex
mys.mys
nde.nde
nld.nld
noan.noan
noap.noap
nor.nor
oeu.oeu
osea.osea
pol.pol
prt.prt
rcam.rcam
rcz.rcz
rfa.rfa
ris.ris
rjan57.rjan57
rom.rom
rsaf.rsaf
rsam.rsam
rsas.rsas
rsl.rsl
rus.rus
slo.slo
sui.sui
swe.swe
tha.tha
tur.tur
ukr.ukr
usa.usa
vnm.vnm
zaf.zaf
# European Union
eu27.(aut, bel, bgr, cro, dnk, esp, fin, fra, grc, hun, irl, ita, nld, pol, prt, rcz, rfa, rom, rsl, slo, swe, blt)
# Grand coalitions (all)
grand.(aut, bel, bgr, cro, dnk, esp, fin, fra, grc, hun, irl, ita, nld, pol, prt, rcz, rfa, rom, rsl, slo, swe, blt, gbr, arg, aus, bra, can, chl, chn, cor, egy, golf57, idn, jpn, meme, mex, mys, nde, noan, noap, nor, osea, rcam, ris, rjan57, rsaf, rsam, rsas, rus, sui, tha, tur, ukr, usa, vnm, zaf, oeu)
/;


# In CBAscenario this set is defined in a custom file
$ifthen.skip not %policy%=="clt-scenario"
# Mapping set declaring which coalitions are active for eac time period
* It can be overwritten in policy file using
SET map_t_clt(t,clt) "Mapping set between time and coalitions" /
(1*3).grand
(4*58).(arg,aus,aut,bel,bgr,blt,bra,can,chl,chn,cor,cro,dnk,egy,esp,fin,fra,gbr,golf57,grc,hun,idn,irl,ita,jpn,meme,mex,mys,nde,nld,noan,noap,nor,oeu,osea,pol,prt,rcam,rcz,rfa,ris,rjan57,rom,rsaf,rsam,rsas,rsl,rus,slo,sui,swe,tha,tur,ukr,usa,vnm,zaf)
/;
# Each coalition-changing time period in map_t_clt mapping
# must be added in this flag sequence
$setglobal coalitions_t_sequence 1 4
$endif.skip

# Control set for active coalitions
SET cltsolve(clt);
* Initialized to no
cltsolve(clt) = no;

# MACRO mapping between coalitions and belonging regions
$macro mapclt(n)    map_clt_n(&clt,n)
$macro mapcclt(nn)  map_clt_n(&clt,nn)


##  BEFORE SOLVE
#_________________________________________________________________________
$elseif.ph %phase%=='before_solve'

* Set which coalitions are now active
loop(clt, cltsolve(clt) = yes$(map_t_clt('%tfix%',clt)); );


#===============================================================================
*     ///////////////////////     REPORTING     ///////////////////////
#===============================================================================

##  GDX ITEMS
#_________________________________________________________________________
$elseif.ph %phase%=='gdx_items'

clt
map_clt_n
map_t_clt


$endif.ph
