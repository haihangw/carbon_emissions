// Merge economic data with emissions data
// Drop unused variables 

// change directory to the folder that contains the file you need
cd ""
use export+emission, replace
rename nacerev2corecode4digits nace
drop if missing(nace)

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

drop if or12 == "n.a."
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
drop if af12 > 6 | af12 < 0.25 // keep track of the firms I dropped in the appendix 
sum af12
univar af12

drop address city country

drop if (nace >= 5100 & nace <= 5199)

univar af12

// http://ec.europa.eu/eurostat/ramon/nomenclatures/index.cfm?TargetUrl=LST_NOM_DTL&StrNom=NACE_REV2

// Mining and quarrying: 0500-0999
egen count = total(nace >= 500 & nace <= 999)
display count
if (count != 0) {
	gen mining_dummy = 0
	label var mining_dummy "Dummy variable for mining and quarrying"
	replace mining_dummy = 1 if nace >= 500 & nace <= 999
}
drop count


// 	Manufacture of paper and paper products; printing and reproduction of recorded media: 1700-1899
egen count = total(nace >= 1700 & nace <= 1899)
display count
if (count != 0) {
	gen manu_paper_dummy = 0
	label var manu_paper_dummy "Dummy variable for manufacturing of paper and paper products; printing and reproduction of recorded media"
	replace manu_paper_dummy = 1 if nace >= 1700 & nace <= 1899
}
drop count


// 	Manufacture of chemicals and chemical products and of basic pharmaceutical products and pharmaceutical preparations: 2000-2199
egen count = total(nace >= 2000 & nace <= 2199)
display count
if (count != 0) {
	gen manu_chemicals_dummy = 0
	label var manu_chemicals_dummy "Dummy variable for manufacturing of chemicals and chemical products and of basic pharmaceutical products and pharmaceutical preparations"
	replace manu_chemicals_dummy = 1 if nace >= 2000 & nace <= 2199
}
drop count

// 	Manufacture of basic metals and of fabricated metal products, except machinery and equipment: 2400-2599
egen count = total(nace >= 2400 & nace <= 2599)
display count
if (count != 0) {
	gen manu_metal_dummy = 0
	label var manu_metal_dummy "Dummy variable for manufacturing of fabricated metal products, except machinery and equipment"
	replace manu_metal_dummy = 1 if nace >= 2400 & nace <= 2599
}
drop count

// Manufacture of food products, beverages and tobacco products: 1000-1299
// Manufacture of textiles and wearing apparel: 1300-1499 
// Manufacture of leather and related products: 1500-1599 
// Manufacture of wood and of products of wood and cork, 
// except furniture; manufacture of articles of straw and plaiting materials: 1600-1699
// Manufacture of coke and refined petroleum products: 1900-1999
// Manufacture of rubber and plastic products: 2200-2299
// Manufacture of other non-metallic mineral products: 2300-2399
// Manufacture of computer, electronic and optical products and of electrical equipment: 2600-2799
// Manufacture of machinery and equipment n.e.c.: 2800-2899
// Manufacture of motor vehicles, trailers and semi-trailers and of other transport equipment: 2900-3099
// Manufacture of furniture; other manufacturing; repair and installation of machinery and equipment: 3100-3399
egen count = total((nace >= 1000 & nace <= 1299) | ///
(nace >= 1300 & nace <= 1699) | ///
(nace >= 1900 & nace <= 1999) | /// 
(nace >= 2200 & nace <= 2299) | ///
(nace >= 2300 & nace <= 2399) | ///
(nace >= 2600 & nace <= 3399))
display count
if (count != 0) {
	gen manu_other_dummy = 0
	label var manu_other_dummy "Dummy variable for other manufacturing."
	replace manu_other_dummy = 1 if /// 
	((nace >= 1000 & nace <= 1299) | ///
	(nace >= 1300 & nace <= 1699) | ///
	(nace >= 1900 & nace <= 1999) | /// 
	(nace >= 2200 & nace <= 2299) | ///
	(nace >= 2300 & nace <= 2399) | ///
	(nace >= 2600 & nace <= 3399))
}
drop count

 
// Electric power generation, transmission and distribution: 3500-3519
egen count = total(nace >= 3500 & nace <= 3519)
display count
if (count != 0) {
	gen electricity_dummy = 0
	label var electricity_dummy "Dummy variable for electric power generation, transmission and distribution"
	replace electricity_dummy = 1 if nace >= 3500 & nace <= 3519
}
drop count

// Manufacture of gas; distribution of gaseous fuels through mains 
// Steam and air conditioning supply 
// Water supply; sewage, waste management and remediation activities: 3520-3999
egen count = total(nace >= 3520 & nace <= 3999)
display count
if (count != 0) {
	gen gas_and_steam_dummy = 0
	label var gas_and_steam_dummy "Dummy variable for gas, steam, and waste management"
	replace gas_and_steam_dummy = 1 if nace >= 3520 & nace <= 3999
}
drop count

// Other
// Agriculture, forestry and fishing : 0100-0399
// Construction: 4100-4399
// Wholesale and retail trade; repair of motor vehicles, motorcycles and personal and household goods: 4500-4799
// Hotels and restaurants: 5500-5699
// Transport and storage: 4900-5399
// Communication: 5800-6399
// Financial intermediation: 6400-6699
// Real estate, renting and business activities: 6800-7599
// Public administration and defence; compulsory social security: 7700-8299
// Education: 8500-8599
// Health and social work: 8600-8899 
// Other community, social and personal service activities: 9000-9699
// Activities of households: 9700-9899
// Extra-territorial organizations and bodies: 9900-9999
egen count = total((nace >= 0100 & nace <= 0399) | (nace >= 4100 & nace <= 9999))
display count
if (count != 0) {
	gen other_dummy = 0
	label var other_dummy "Dummy variable for other things"
	replace other_dummy = 1 if nace >= 4100 & nace <= 9999
}
drop count

egen count_mining_dummy = total(mining_dummy == 1)
display count_mining_dummy // 8
egen count_manu_paper_dummy = total(manu_paper_dummy == 1)
display count_manu_paper_dummy // 29
egen count_manu_chemical_dummy = total(manu_chemicals_dummy == 1)
display count_manu_chemical_dummy // 20
egen count_manu_metal_dummy = total(manu_metal_dummy == 1)
display count_manu_metal_dummy // 18
egen count_manu_other_dummy = total(manu_other_dummy == 1)
display count_manu_other_dummy // 79
egen count_electricity_dummy = total(electricity_dummy == 1)
display count_electricity_dummy // 94
egen count_gas_and_steam_dummy = total(gas_and_steam_dummy == 1)
display count_gas_and_steam_dummy // 30
egen count_other_dummy = total(other_dummy == 1)
display count_other_dummy // 33

display count_mining_dummy + count_manu_paper_dummy ///
+ count_manu_chemical_dummy + count_manu_metal_dummy /// 
+ count_manu_other_dummy + count_electricity_dummy /// 
+ count_gas_and_steam_dummy + count_other_dummy

drop count_mining_dummy count_manu_paper_dummy /// 
count_manu_chemical_dummy count_manu_metal_dummy /// 
count_manu_other_dummy count_electricity_dummy /// 
count_gas_and_steam_dummy count_other_dummy

gen or12–11 = or12 - or11
gen or11–10 = or11 - or10
gen or10–09 = or10 - or09
gen or09–08 = or09 - or08

gen ne12–11 = ne12 - ne11
gen ne11–10 = ne11 - ne10
gen ne10–09 = ne10 - ne09
gen ne09–08 = ne09 - ne08
