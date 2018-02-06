// Handle economic data
// change directory to the folder that contains the file you need
cd "/Users/hedgewang/Google Drive/carbon_emissions/Economic Data"
// insheet using "x.csv", clear
insheet using "Spain.csv", clear
drop v1
rename company acc_holder_name
rename streetnobuildingetcline1 address
duplicates list acc_holder_name
drop if missing(acc_holder_name)
cd "/Users/hedgewang/Google Drive/carbon_emissions/DTA/Economic Data"
save "Economic_Spain", replace

// Handle emissions data
// change directory to the folder that contains the file you need
cd "/Users/hedgewang/Google Drive/carbon_emissions/Emissions Data/Modified Countries (csv)"
// insheet using "x.csv", clear
insheet using "Spain.csv", clear
rename (allowanceinallocationin2005 allowanceinallocationin2006 /// 
allowanceinallocationin2007 allowanceinallocationin2008 /// 
allowanceinallocationin2009 allowanceinallocationin2010 /// 
allowanceinallocationin2011 allowanceinallocationin2012 /// 
allowanceinallocationin2013 allowanceinallocationin2014 /// 
allowanceinallocationin2015 allowanceinallocationin2016 /// 
allowanceinallocationin2017 allowanceinallocationin2018 /// 
allowanceinallocationin2019 allowanceinallocationin2020) /// 
(aa05 aa06 aa07 aa08 aa09 aa10 aa11 aa12 aa13 ///
aa14 aa15 aa16 aa17 aa18 aa19 aa20)

rename (verifiedemissionsin2005 verifiedemissionsin2006 /// 
verifiedemissionsin2007 verifiedemissionsin2008 /// 
verifiedemissionsin2009 verifiedemissionsin2010 /// 
verifiedemissionsin2011 verifiedemissionsin2012 /// 
verifiedemissionsin2013 verifiedemissionsin2014 /// 
verifiedemissionsin2015 verifiedemissionsin2016 /// 
verifiedemissionsin2017 verifiedemissionsin2018 /// 
verifiedemissionsin2019 verifiedemissionsin2020) /// 
(ve05 ve06 ve07 ve08 ve09 ve10 ve11 ve12 ve13 ///
ve14 ve15 ve16 ve17 ve18 ve19 ve20)

rename (unitssurrenderedin2005 unitssurrenderedin2006 /// 
unitssurrenderedin2007 unitssurrenderedin2008 /// 
unitssurrenderedin2009 unitssurrenderedin2010 /// 
unitssurrenderedin2011 unitssurrenderedin2012 /// 
unitssurrenderedin2013 unitssurrenderedin2014 /// 
unitssurrenderedin2015 unitssurrenderedin2016 /// 
unitssurrenderedin2017 unitssurrenderedin2018 ///
unitssurrenderedin2019 unitssurrenderedin2020) /// 
(us05 us06 us07 us08 us09 us10 us11 us12 us13 ///
us14 us15 us16 us17 us18 us19 us20)

rename accounttype acc_type
rename accountholdername acc_holder_name
rename mainaddressline address 

drop aa05 aa06 aa07 aa08 aa09 aa10 aa11
drop aa13 aa14 aa15 aa16 aa17 aa18 aa19 aa20
drop ve05 ve06 ve07 ve08 ve09 ve10 ve11
drop ve13 ve14 ve15 ve16 ve17 ve18 ve19 ve20
drop us05 us06 us07 us08 us09 us10 us11 us12 us13 ///
us14 us15 us16 us17 us18 us19 us20

drop if ve12 == "Not Reported"
destring ve12, replace

collapse (sum) aa12 = aa12 (sum) ve12 = ve12, by(acc_holder_name address city) 
drop if missing(acc_holder_name) 
drop address city
collapse (sum) aa12 = aa12 (sum) ve12 = ve12, by(acc_holder_name)
cd "/Users/hedgewang/Google Drive/carbon_emissions/DTA/Emissions Data"
save "Emissions_Spain", replace

// Merge
cd "/Users/hedgewang/Google Drive/carbon_emissions/DTA/Economic Data"
merge 1:1 acc_holder_name using Economic_Spain
cd "/Users/hedgewang/Google Drive/carbon_emissions/DTA"
save "Spain", replace

// Data Handling
use Spain, replace
rename nacerev2corecode4digits nace
drop if missing(nace)
// drop if nace == "Credit needed"
// destring nace, replace


rename (operatingrevenueturnovermeur2017 operatingrevenueturnovermeur2016 /// 
operatingrevenueturnovermeur2015 operatingrevenueturnovermeur2014 /// 
operatingrevenueturnovermeur2013 operatingrevenueturnovermeur2012 /// 
operatingrevenueturnovermeur2011 operatingrevenueturnovermeur2010 /// 
operatingrevenueturnovermeur2009 operatingrevenueturnovermeur2008) /// 
(or17 or16 or15 or14 or13 or12 or11 or10 or09 or08)

rename (numberofemployees2017 numberofemployees2016 /// 
numberofemployees2015 numberofemployees2014 /// 
numberofemployees2013 numberofemployees2012 /// 
numberofemployees2011 numberofemployees2010 /// 
numberofemployees2009 numberofemployees2008) /// 
(ne17 ne16 ne15 ne14 ne13 ne12 ne11 ne10 ne09 ne08)

drop or17 or16 or15 or14 or13
drop ne17 ne16 ne15 ne14 ne13

drop if or12 == "n.a." || or12 == "Credit needed"
destring or12, replace ignore(",")
drop if or12 == .

drop if or11 == "n.a."
destring or11, replace ignore(",")
drop if or11 == .

drop if or10 == "n.a."
destring or10, replace ignore(",")
drop if or10 == .

drop if or09 == "n.a."
destring or09, replace ignore(",")
drop if or09 == .

drop if or08 == "n.a."
destring or08, replace ignore(",")
drop if or08 == .

drop if ne12 == "n.a."
destring ne12, replace ignore(",")
drop if ne12 == .

drop if ne11 == "n.a."
destring ne11, replace ignore(",")
drop if ne11 == .

drop if ne10 == "n.a."
destring ne10, replace ignore(",")
drop if ne10 == .

drop if ne09 == "n.a."
destring ne09, replace ignore(",")
drop if ne09 == .

drop if ne08 == "n.a."
destring ne08, replace ignore(",")
drop if ne08 == .

generate af12 = aa12 / ve12
drop if af12 > 6 | af12 < 0.25
drop address city country
destring nace, replace
drop if (nace >= 5100 & nace <= 5199)
gen country = "Spain"
cd "/Users/hedgewang/Google Drive/carbon_emissions/DTA"
save "Spain", replace

use Spain.dta, replace
drop _merge
save Spain.dta, replace
