************************************************************
*					GET AND CLEAN DATA				   	   *
************************************************************
graph drop _all
clear all
cd "/Users/hainex/Documents/DSE/Microeconometrics and Casual Infernece/project_presidential_election"

use panel_data_2.dta
encode statename, gen(state) // generate state variable

order state year vp i dper dur gdp_4 gdp_2 gdp_1 n_g_4 n_g_2 def_15q n_p_15q p_3_q e_4 e_2 e_1 n_e_4 n_e_2 gini_4 gini_2 gini_1 n_gi_4 n_gi_2 hp_growth i_o_growth_3q i_o_growth_15q oil_price_growth_3q oil_price_growth_15q nasdaq_growth_3q nasdaq_growth_15q elec_votes


sort year state 

* label variables
lab var year "Election year"
lab var vp "Dem share of presidential vote"
lab var elec_votes "State electoral votes (2012-2016)"

lab var i "1 [-1] if Dem [Rep] presidential incumbent"
lab var dper "1 [-1] {0} Dem [Rep] presidential incumbent {not} running again"
lab var dur "Duration party in charge"

lab var gdp_4 "Per capita real GDP growth during all 4 years of admin"
lab var gdp_2 "Per capita real GDP growth during last 2 years of admin"
lab var gdp_1 "Per capita real GDP growth during last 1 year of admin"
lab var n_g_4 "No. years per capita real GDP growth>mean during all 4 years of admin"
lab var n_g_2 "No. years per capita real GDP growth>mean during last 2 years of admin"

lab var def_15q "Inflation rate (first 15Q of admin)"

lab var n_p_15q "No. quarters personal income growth>mean during (first 15Q of admin)"
lab var p_3_q "Per capita personal income Q1-Q3 election year"

lab var e_4 "Employment growth during all 4 years of admin"
lab var e_2 "Employment growth during last 2 years of admin"
lab var e_1 "Employment growth during last 1 year of admin"
lab var n_e_4 "No. years employment growth>mean during all 4 years of admin"
lab var n_e_2 "No. years employment growth>mean during last 2 years of admin"

lab var gini_4 "Gini index growth during all 4 years of admin"
lab var gini_2 "Gini index growth during last 2 years of admin"
lab var gini_1 "Gini index growth during last 1 year of admin"
lab var n_gi_4 "No. years Gini index growth>mean during all 4 years of admin"
lab var n_gi_2 "No. years Gini index growth>mean during last 2 years of admin"


lab var hp_growth "house price growth during last 1 years of admin"
lab var i_o_growth_3q "import export growth during last 3 quarters of admin"
lab var i_o_growth_15q "import export growth during last 15 quarters of admin"
lab var oil_price_growth_3q "oil price growth during last 3 quarters of admin"
lab var oil_price_growth_15q "oil price growth during last 15 quarters of admin"
lab var nasdaq_growth_3q "nasdaq growth during last 3 quarters of admin"
lab var nasdaq_growth_15q "nasdaq growth during last 15 quarters of admin"



* label values of categorical variables
lab def incumbent 1 "Dem incumbent" -1 "Rep incumbent" 0 "Third party"
lab val i incumbent

label define dper 1 "Dem running again" -1 "Rep running again" 0 "Incumbent not running again"
lab val dper dper

lab def dur 0 "Dem or Rep party 1 term" /*
*/ 1 "Dem party 2 terms"  2 "Dem party 6 terms" /*
*/ -1 "Rep party 2 terms"    -2 "Rep party 6 terms"
lab val dur dur

* Presidents 
gen president = "WILSON" 
lab var president "President name"
replace president = "CARTER" 	if year==1976
replace president = "REAGAN" 	if year==1980
replace president = "REAGAN" 	if year==1984
replace president = "BUSH" 		if year==1988
replace president = "CLINTON" 	if year==1992
replace president = "CLINTON" 	if year==1996
replace president = "BUSH (W.)" if year==2000
replace president = "BUSH (W.)" if year==2004
replace president = "OBAMA" 	if year==2008
replace president = "OBAMA" 	if year==2012
replace president = "TRUMP" 	if year==2016
order dur dper i president 



* Interactions
gen p_3_q_i 					= p_3_q*i
gen def_15q_i 					= def_15q*i
gen n_p_15q_i 					= n_p_15q*i
gen n_g_4_i 					= n_g_4*i
gen gdp_1_i						= gdp_1*i
gen hp_growth_i 				= hp_growth*i
gen i_o_growth_3q_i 			= i_o_growth_3q*i
gen i_o_growth_15q_i			= i_o_growth_15q*i
gen oil_price_growth_3q_i		= oil_price_growth_3q*i
gen oil_price_growth_15q_i		= oil_price_growth_15q*i
gen nasdaq_growth_3q_i			= nasdaq_growth_3q*i
gen nasdaq_growth_15q_i			= nasdaq_growth_15q*i
gen e_4_i 						= e_4*i 
gen e_2_i 						= e_2*i 
gen e_1_i 						= e_1*i 
gen n_e_4_i 					= n_e_4*i 
gen n_e_2_i 					= n_e_2*i 

gen gini_4_i						= gini_4*i
gen gini_2_i						= gini_2*i
gen gini_1_i						= gini_1*i
gen n_gi_4_i						= n_gi_4*i
gen n_gi_2_i						= n_gi_2*i

label var p_3_q_i 					"p_3_q x i"
label var def_15q_i 				"def_15q x i"
label var n_p_15q_i 				"n_p_15q x i"
label var n_g_4_i 					"n_g_4 x i"
label var gdp_1_i 					"gdp_1 x i"

label var hp_growth_i 			  	"hp_growth x i"
label var i_o_growth_3q_i 		  	"i_o_growth_3q x i"
label var i_o_growth_15q_i		  	"i_o_growth_15q x i"
label var oil_price_growth_3q_i	  	"oil_price_growth_3q x i"
label var oil_price_growth_15q_i  	"oil_price_growth_15q x i"
label var nasdaq_growth_3q_i	  	"nasdaq_growth_3q x i"
label var nasdaq_growth_15q_i	  	"nasdaq_growth_15q x i"

label var e_4_i 					"e_4 x i"
label var e_2_i 					"e_2 x i"
label var e_1_i 					"e_1 x i"
label var n_e_4_i 					"n_e_4 x i"	
label var n_e_2_i 					"n_e_2 x i"

label var gini_4_i					 "gini_4 x i"
label var gini_2_i					 "gini_2 x i"
label var gini_1_i					 "gini_1 x i"	
label var n_gi_4_i					 "n_gi_4 x i"
label var n_gi_2_i					 "n_gi_2 x i"


tab state, gen(S)

xtset state year, delta(4)

/*
************************************************************
*						WHY FE ARE USEFUL? 			   	   *
************************************************************

reg vp p_3_q_i if year == 2016

twoway (scatter vp p_3_q_i) (lfit vp p_3_q_i) if year == 2016, ytitle("Democratic share") xtitle("Per capita personal income Q1-Q3 election year x incumbency") title("Per capita personal income Q1-Q3 election year x incumbency and Democratic share - 2016") name(vp_p_3_q_i_2016) legend(order(1 "Data" 2 "42.6 + 376.02*p_3_q_i"))


reg vp p_3_q_i if state == "AK":state

twoway (scatter vp p_3_q_i) (lfit vp p_3_q_i) if state=="AK":state, ytitle("Democratic share") xtitle("Per capita personal income Q1-Q3 election year x incumbency") title("Per capita personal income Q1-Q3 election year x incumbency and Democratic share - AK") name(vp_p_3_q_i_ak)legend(order(1 "Data" 2 "37.41 + -30.39*p_3_q_i"))

*/
*********************************************************************
*		FAIR EQUATION ON PANEL DATA - MODELS AND ESTIMATES			*	
*********************************************************************


** FAIR VARIABLES:
sum vp i dper dur gdp_1_i def_15q_i n_g_4_i

** Here we will regress different models starting from a wrong model
** that doesn't account for heteroskedasticity nor correlation all the way 
** to the final model w/ different FE


* Model w/out FE or robust estimates
qui xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i
est sto m0

* Model w/out FE but from now on we take into account heteroskedasticity and correlation

* We notice that with the vce(cluster ) command we let different states to have different variances

* but we restrict the correlation to residual within each state

qui xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i, vce(cluster state)
est sto m1

* Model w/ state fixed effect accounted for through the dummies i.state
xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i, re
est sto re

* Here we check if the state FE are statistically significant (poolability test)

xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i S* i.year, fe


* Model w/ both state (i.state) and year (i.year) FE
xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i S* i.year, fe vce(cluster state)
est sto fe


*hausman fe re
* Here we check if the year FE are statistically significant
testparm i.year
testparm gdp_1_i def_15q_i n_g_4_i dur dper i


* We then finally compare the estimates of the four models above
*estimates table m0 m1 m2 m3, stats(N r2_a) star(.1 .05 .01) /*
**/ keep(i dper dur gdp_1_i def_15q_i n_g_4_i) /*
***/ b(%4.3f) stfmt(%4.3f) varlabel



/*
From the two tests on our FE we conclude that both state and year FE are statistically significant
and though we will include them in our models.
From the estimates comparison we notice that adding state-FE does not change our estimates,
but adding year-FE radically change the consiguration of our estimates, in particular
the incumbency estimates (i dur dper) loose their significance together w/ gdp_1_i
and the economic estimates (def_15q_i n_g_4_i) become strongly significant 
*/



** At last we test for the joint significance of our economic variables 
** And from the test we conclude that they are jointly statistically significant



/*
					HERE WE REPORT REGRESSIONS RESULTS TO COMPARE

			**xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i
           i |  -4.075734   1.145374    -3.56   0.000    -6.320626   -1.830841
        dper |  -.5936401   .5438407    -1.09   0.275    -1.659548    .4722681
         dur |    5.84078   .4872364    11.99   0.000     4.885815    6.795746
     gdp_1_i |   32.10495   7.264757     4.42   0.000     17.86629    46.34361
   def_15q_i |   .1156384   .1508892     0.77   0.443     -.180099    .4113759
     n_g_4_i |    .251413   .2192688     1.15   0.252     -.178346    .6811719


			**xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i, vce(cluster state)
           i |  -4.075734    1.61702    -2.52   0.012    -7.245034   -.9064332
        dper |  -.5936401   .4136422    -1.44   0.151    -1.404364    .2170837
         dur |    5.84078   .3887468    15.02   0.000     5.078851     6.60271
     gdp_1_i |   32.10495   10.53944     3.05   0.002     11.44803    52.76187
   def_15q_i |   .1156384   .1957391     0.59   0.555    -.2680032    .4992801
     n_g_4_i |    .251413   .2045252     1.23   0.219     -.149449    .6522749

	 
			**xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i i.state, vce(cluster state)
           i |  -4.100687   1.687391    -2.43   0.015    -7.407912   -.7934617
        dper |  -.5955846   .4323902    -1.38   0.168    -1.443054    .2518847
         dur |   5.836371   .4092393    14.26   0.000     5.034276    6.638465
     gdp_1_i |   32.45772   10.88493     2.98   0.003     11.12366    53.79179
   def_15q_i |   .1167383   .2051093     0.57   0.569    -.2852686    .5187452
     n_g_4_i |   .2575036   .2068008     1.25   0.213    -.1478185    .6628256

			
			**xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i i.state i.year, vce(cluster state)
			
           i |   6.071172    2.07809     2.92   0.003      1.99819    10.14415
        dper |   -.456137   1.436141    -0.32   0.751    -3.270922    2.358648
         dur |  -2.753291   1.438008    -1.91   0.056    -5.571736    .0651532
     gdp_1_i |   5.897652   7.717098     0.76   0.445    -9.227581    21.02289
   def_15q_i |  -.8979471   .2923686    -3.07   0.002    -1.470979   -.3249152
     n_g_4_i |    .670225   .1948659     3.44   0.001     .2882947    1.052155

*/
		
		
*********************************************************************
*			FAIR EQUATION ON PANEL DATA - PREDICTIONS				*	
*********************************************************************

** Here we will use our last model to actually predict the election outcome of 2012 and 2016.
** We will actually recompute our model estimates both on data w/ year < 2012 and year < 2016
** to check the goodness of our model by predicting as if we did not know the outcome. 

* Generate variable to take note of the winner for each state
gen dem_win = 0
gen dem_elec_votes = 0


lab var dem_win "1 [0] if Dem [Rep] is the forecasted winner"
lab var dem_elec_votes "Number of Predicted Dem electoral votes"


* estimate coefficents w/ FE model
xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i S* i.year, vce(cluster state) 

*xtreg vp i dper dur gdp_1_i def_15q_i n_g_4_i S* i.year, fe vce(cluster state)

** PREDICTION

* compute fitted values for 2012 
predict vphat, xb
gen uhat = vp - vphat

*assign winner to each state based on fitted values
replace dem_win = 1 	if vphat>50


* Compute the total electoral votes by year
replace dem_elec_votes = elec_votes * dem_win
egen total_elec_votes = total(dem_elec_votes), by(year)


** SHOW PREDICTIONS

twoway (scatter vphat state) if year==2012 | year==2016 ,ytitle("Forecasted Democratic Share") 	by(year) name(vp_predictions)
twoway (scatter uhat state) if year==2012 | year==2016, ytitle("Forecast Error")				by(year) name(error_predictions)
graph combine vp_predictions error_predictions, rows(2)  xcommon

list year total_elec_votes if state==1 &  year >2011


***********************************************************************
*							LASSO MODEL								  *
***********************************************************************
							*add square variables
							*store variables you want to test with "global setname"
							*could also try with time fixed effects (?)
							*put FE in another global (exclude D1 and Y1, becomes base case)
							*create global with GDP and StateFE 
							*statistics/lasso/choose dep var/always include global with GDP/plugin heterosk formula
							*the non zero coeff will include the selected and the fixed vars
							*"lassocoef" to see selected
							*rerun LASSO with dep policy var and see which are useful
							*take union of results and run xtreg

* We compute other possible variables (TODO keep this at minimum, we will need to interpret them)
gen hp_growth_i_2 			= hp_growth_i^2 				
gen i_o_growth_3q_i_2		= i_o_growth_3q_i^2			
gen i_o_growth_15q_i_2		= i_o_growth_15q_i^2			
gen oil_price_growth_3q_i_2	= oil_price_growth_3q_i^2		
gen oil_price_growth_15q_i_2= oil_price_growth_15q_i^2		
gen nasdaq_growth_3q_i_2	= nasdaq_growth_3q_i^2			
gen nasdaq_growth_15q_i_2	= nasdaq_growth_15q_i^2	
gen n_p_15q_i_2				= n_p_15q_i^2		
gen p_3_q_i_2				= p_3_q_i^2		
gen e_4_i_2					= e_4_i^2		
gen e_2_i_2					= e_2_i^2 		
gen e_1_i_2					= e_1_i^2 		
gen n_e_4_i_2				= n_e_4_i^2 		
gen n_e_2_i_2				= n_e_2_i^2 		


gen lhp_growth_i 			= log(hp_growth_i) 				
gen li_o_growth_3q_i		= log(i_o_growth_3q_i)			
gen li_o_growth_15q_i		= log(i_o_growth_15q_i)			
gen loil_price_growth_3q_i	= log(oil_price_growth_3q_i)		
gen loil_price_growth_15q_i	= log(oil_price_growth_15q_i)		
gen lnasdaq_growth_3q_i		= log(nasdaq_growth_3q_i)			
gen lnasdaq_growth_15q_i	= log(nasdaq_growth_15q_i)	
gen ln_p_15q_i				= log(n_p_15q_i)	
gen lp_3_q_i				= log(p_3_q_i)	
gen le_4_i					= log(e_4_i)		
gen le_2_i					= log(e_2_i)		
gen le_1_i					= log(e_1_i)		
gen ln_e_4_i				= log(n_e_4_i) 	
gen ln_e_2_i				= log(n_e_2_i)	



* We always keep FE outside the lasso (we know they are jointly statistically significant)
global Xfixed S* i.year

* We recall fair variables
sum vp i dper dur gdp_1_i def_15q_i n_g_4_i

describe hp_growth i_o_growth_3q i_o_growth_15q  oil_price_growth_3q oil_price_growth_15q nasdaq_growth_3q nasdaq_growth_15q 

* We recall our added variables (basic, w/out transformations)
summarize hp_growth_i i_o_growth_3q_i i_o_growth_15q_i oil_price_growth_3q_i oil_price_growth_15q_i nasdaq_growth_3q_i nasdaq_growth_15q_i n_p_15q_i p_3_q_i e_4_i e_2_i e_1_i n_e_4_i n_e_2_i 


/*
 ALL VARIABLES 
global XLBig i dper dur def_15q_i n_g_4_i hp_growth_i i_o_growth_3q_i i_o_growth_15q_i oil_price_growth_3q_i oil_price_growth_15q_i nasdaq_growth_3q_i nasdaq_growth_15q_i n_p_15q_i p_3_q_i e_4_i e_2_i e_1_i n_e_4_i n_e_2_i hp_growth_i_2 i_o_growth_3q_i_2	i_o_growth_15q_i_2 oil_price_growth_3q_i_2 oil_price_growth_15q_i_2 nasdaq_growth_3q_i_2 nasdaq_growth_15q_i_2 n_p_15q_i_2 p_3_q_i_2 e_4_i_2 e_2_i_2 e_1_i_2 n_e_4_i_2 n_e_2_i_2 lhp_growth_i li_o_growth_3q_i li_o_growth_15q_i loil_price_growth_3q_i loil_price_growth_15q_i	lnasdaq_growth_3q_i lnasdaq_growth_15q_i ln_p_15q_i lp_3_q_i le_4_i le_2_i le_1_i ln_e_4_i ln_e_2_i		

* SUBSET OF USEFUL VARIABLES
global XLUseful hp_growth_i oil_price_growth_3q_i oil_price_growth_15q_i nasdaq_growth_3q_i nasdaq_growth_15q_i   lhp_growth_i li_o_growth_3q_i li_o_growth_15q_i loil_price_growth_3q_i loil_price_growth_15q_i	lnasdaq_growth_3q_i lnasdaq_growth_15q_i 
		
*/

/*
* Here we apply NAIVE LASSO (wrong approach: does not take into account varables that are correlated w/ gdp_1_i but it just keep gdp_1_i as fixed)
global XLNaive i dper dur def_15q_i n_g_4_i hp_growth_i i_o_growth_3q_i i_o_growth_15q_i oil_price_growth_3q_i oil_price_growth_15q_i nasdaq_growth_3q_i nasdaq_growth_15q_i n_p_15q_i p_3_q_i e_4_i e_2_i e_1_i n_e_4_i n_e_2_i 
lasso linear vp ($Xfixed gdp_1_i) $XLNaive, selection(plugin, heteroskedastic) nolog
est sto naive_lasso
lassocoef

* Now we apply DS LASSO (right approach: computes two lasso selections, both on vp and gdp_1_i, and take into account the union of the outcomes)

global XLDS i dper dur def_15q_i n_g_4_i hp_growth_i i_o_growth_3q_i i_o_growth_15q_i oil_price_growth_3q_i oil_price_growth_15q_i nasdaq_growth_3q_i nasdaq_growth_15q_i n_p_15q_i p_3_q_i e_4_i e_2_i e_1_i n_e_4_i n_e_2_i 
lasso linear vp ($Xfixed) $XLDS, selection(plugin, heteroskedastic) 
est sto ds_lasso_vp
lassocoef
lasso linear gdp_1_i ($Xfixed) $XLDS, selection(plugin, heteroskedastic)
est sto ds_lasso_gdp_1_i
lassocoef

* Now we apply DS BIG LASSO (right approach: computes two lasso selections, both on vp and gdp_1_i, and take into account the union of the outcomes)
lasso linear vp ($Xfixed) $XLBig, selection(plugin, heteroskedastic) 
est sto ds_lasso_vp
lassocoef
lasso linear gdp_1_i ($Xfixed) $XLBig, selection(plugin, heteroskedastic) nolog
est sto ds_lasso_gdp_1_i
lassocoef

* Now we apply DS USEFUL LASSO (right approach: computes two lasso selections, both on vp and gdp_1_i, and take into account the union of the outcomes)
lasso linear vp ($Xfixed) $XLUseful, selection(plugin)) nolog
est sto ds_lasso_vp
lassocoef
lasso linear gdp_1_i ($Xfixed) $XLUseful, selection(plugin, heteroskedastic) nolog
est sto ds_lasso_gdp_1_i
lassocoef

global XLDS i dper dur def_15q_i n_g_4_i hp_growth_i i_o_growth_3q_i i_o_growth_15q_i oil_price_growth_3q_i oil_price_growth_15q_i nasdaq_growth_3q_i nasdaq_growth_15q_i n_p_15q_i p_3_q_i e_4_i e_2_i e_1_i n_e_4_i n_e_2_i 

** BASTIANIN APPROACH 1

dsregress vp gdp_1_i, controls(($Xfixed) $XLDS) selection(plugin, heteroskedastic)
est sto ds
lassocoef (.,for(vp)) (.,for(gdp_1_i)) // check selected variables
*/
global XLDS i dper dur def_15q_i n_g_4_i hp_growth_i i_o_growth_3q_i i_o_growth_15q_i oil_price_growth_3q_i oil_price_growth_15q_i nasdaq_growth_3q_i nasdaq_growth_15q_i n_p_15q_i p_3_q_i e_4_i e_2_i e_1_i n_e_4_i n_e_2_i 
** BASTIANIN APPROACH 2


dsregress vp gdp_1_i, controls((S* i.year def_15q_i n_g_4_i i dur dper) hp_growth_i i_o_growth_3q_i i_o_growth_15q_i oil_price_growth_3q_i oil_price_growth_15q_i nasdaq_growth_3q_i nasdaq_growth_15q_i n_p_15q_i p_3_q_i e_4_i e_2_i e_1_i n_e_4_i n_e_2_i) select(plugin) // DS LASSO + cross vaidation as robustness check

estimates store lassocv
lassocoef (.,for(vp))(.,for(gdp_1_i)) 
/*
After a few test we discover that def_15q_i seems to be the "best" policy variable,
as expected it seems correlated w/ a lot of new variables we introduced such as 

n_g_4_i    
hp_growth_i
i_o_growth_15q_i  
n_p_15q_i
p_3_q_i    
e_4_i    
e_1_i    
n_e_4_i    
n_e_2_i    
e_2_i 


We will then choose def_15q_i as policy variable and compute the LASSO model as follows:
*/




/*					
					**HERE WE REPORT THE RESULTS				
                    i |  -29.26252   7.110523    -4.12   0.000    -43.54443   -14.98061
                  dur |   5.367757   .4878797    11.00   0.000     4.387822    6.347692
            def_15q_i |   3.608734   1.004287     3.59   0.001     1.591564    5.625905
              n_g_4_i |   .4681602   .2164319     2.16   0.035     .0334439    .9028765
      i_o_growth_3q_i |   36.04162   9.540192     3.78   0.000     16.87959    55.20366
     i_o_growth_15q_i |  -.8990567   1.489957    -0.60   0.549    -3.891724    2.093611
oil_price_growth_3q_i |   .2228236   .0343716     6.48   0.000     .1537861     .291861
   nasdaq_growth_3q_i |  -.0163647   .0642416    -0.25   0.800    -.1453978    .1126683
            n_p_15q_i |    .252795   .0799867     3.16   0.003      .092137    .4134531
*/

** We also test for statistical significance of our added variables 
testparm vp gdp_1_i hp_growth_i n_p_15q_i n_g_4_i i_o_growth_15q_i p_3_q_i e_1_i e_2_i e_4_i n_e_2_i n_e_4_i 
** And we get that they are statistically significant




*********************************************************************
*			LASSO EQUATION ON PANEL DATA - PREDICTIONS				*	
*********************************************************************

** Here we will use our last model to actually predict the election outcome of 2012 and 2016.
** We will actually recompute our model estimates both on data w/ year < 2012 and year < 2016
** to check the goodness of our model by predicting as if we did not know the outcome. 

* Generate variable to take note of the winner for each state
gen dem_win_l = 0
gen dem_elec_votes_l = 0

lab var dem_win_l "1 [0] if Dem [Rep] is the forecasted winner"
lab var dem_elec_votes_l "Number of Predicted Dem electoral votes"


xtreg vp gdp_1_i dur dper i oil_price_growth_15q_i e_1_i n_g_4_i S* i.year, vce(cluster state)
est sto lasso_ds


* estimate coefficents w/ FE model
*qui xtreg vp gdp_1_i n_g_4_i i_o_growth_15q_i p_3_q_i e_1_i n_e_2_i S* i.year, vce(cluster state) 


** PREDICTION
* compute fitted values for 2012 
predict vphat_l, xb
gen uhat_l = vp - vphat_l

*assign winner to each state based on fitted values
replace dem_win_l = 1 	if vphat_l>50

* Compute the total electoral votes by year
replace dem_elec_votes_l = elec_votes * dem_win_l
egen total_elec_votes_l = total(dem_elec_votes_l), by(year)


** SHOW PREDICTIONS

twoway (scatter vphat_l state) if year==2012 | year==2016 ,ytitle("Forecasted Democratic Share") 	by(year) name(vp_predictions_l)
twoway (scatter uhat_l state) if year==2012 | year==2016, ytitle("Forecast Error")				by(year) name(error_predictions_l)
graph combine vp_predictions_l error_predictions_l, rows(2)  xcommon

list year total_elec_votes_l if state==1 & year >2011



***********************************************************************
*						LASSO - OLS COMPARISON						  *
***********************************************************************


* at last we compare the LASSO estimates with OLS model estimates
estimates table lasso_ds m3, stats(N r2_a) star(.1 .05 .01) /*
*/ keep(i dper dur gdp_1_i def_15q_i n_g_4_i) /*
*/ b(%4.3f) stfmt(%4.3f) varlabel

* And here we compare the two forecasts
list year total_elec_votes_2012 total_elec_votes_2016 total_elec_votes_2012_L total_elec_votes_2016_L if state==1 & year >2011
