cd "/Users/hedgewang/Google Drive/carbon_emissions/DTA"
use Belgium.dta, replace
append using Bulgaria.dta Czech_Republic.dta /// 
Finland.dta France.dta /// 
Italy.dta Spain.dta Germany.dta

sum af12
univar af12

drop if (nace >= 5100 & nace <= 5199)
univar af12

// http://ec.europa.eu/eurostat/ramon/nomenclatures/index.cfm?TargetUrl=LST_NOM_DTL&StrNom=NACE_REV2

// Mining and quarrying: 0500-0999
// 15
egen count = total(nace >= 500 & nace <= 999)
display count
if (count != 0) {
	gen mining_dummy = 0
	label var mining_dummy "Dummy variable for mining and quarrying"
	replace mining_dummy = 1 if nace >= 500 & nace <= 999
}
drop count


// 	Manufacture of paper and paper products; printing and reproduction of recorded media: 1700-1899
// 61
egen count = total(nace >= 1700 & nace <= 1899)
display count
if (count != 0) {
	gen manu_paper_dummy = 0
	label var manu_paper_dummy "Dummy variable for manufacturing of paper and paper products; printing and reproduction of recorded media"
	replace manu_paper_dummy = 1 if nace >= 1700 & nace <= 1899
}
drop count


// 	Manufacture of chemicals and chemical products and of basic pharmaceutical products and pharmaceutical preparations: 2000-2199
// 74
egen count = total(nace >= 2000 & nace <= 2199)
display count
if (count != 0) {
	gen manu_chemicals_dummy = 0
	label var manu_chemicals_dummy "Dummy variable for manufacturing of chemicals and chemical products and of basic pharmaceutical products and pharmaceutical preparations"
	replace manu_chemicals_dummy = 1 if nace >= 2000 & nace <= 2199
}
drop count

// 	Manufacture of basic metals and of fabricated metal products, except machinery and equipment: 2400-2599
// 37
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
// 237
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
// 139
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
// 80
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
// 59
egen count = total((nace >= 0100 & nace <= 0399) | (nace >= 4100 & nace <= 9999))
display count
if (count != 0) {
	gen other_dummy = 0
	label var other_dummy "Dummy variable for other things"
	replace other_dummy = 1 if ((nace >= 0100 & nace <= 0399) | (nace >= 4100 & nace <= 9999))
}
drop count

egen count_mining_dummy = total(mining_dummy == 1)
display count_mining_dummy // 15
egen count_manu_paper_dummy = total(manu_paper_dummy == 1)
display count_manu_paper_dummy // 61
egen count_manu_chemical_dummy = total(manu_chemicals_dummy == 1)
display count_manu_chemical_dummy // 74
egen count_manu_metal_dummy = total(manu_metal_dummy == 1)
display count_manu_metal_dummy // 37
egen count_manu_other_dummy = total(manu_other_dummy == 1)
display count_manu_other_dummy // 237
egen count_electricity_dummy = total(electricity_dummy == 1)
display count_electricity_dummy // 139
egen count_gas_and_steam_dummy = total(gas_and_steam_dummy == 1)
display count_gas_and_steam_dummy // 80
egen count_other_dummy = total(other_dummy == 1)
display count_other_dummy // 59

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

gen label = 1
replace label = -1 if or12–11 <= 0
drop or12–11

egen count = total(country == "Belgium")
display count
if (count != 0) {
	gen be = 0
	label var be "Dummy variable for Belgium"
	replace be = 1 if country == "Belgium"
}
drop count

egen count = total(country == "Bulgaria")
display count
if (count != 0) {
	gen bg = 0
	label var bg "Dummy variable for Bulgaria"
	replace bg = 1 if country == "Bulgaria"
}
drop count

egen count = total(country == "Czech_Republic")
display count
if (count != 0) {
	gen cz = 0
	label var cz "Dummy variable for Czech Republic"
	replace cz = 1 if country == "Czech_Republic"
}
drop count

egen count = total(country == "Finland")
display count
if (count != 0) {
	gen fi = 0
	label var fi "Dummy variable for Finland"
	replace fi = 1 if country == "Finland"
}
drop count

egen count = total(country == "France")
display count
if (count != 0) {
	gen fr = 0
	label var fr "Dummy variable for France"
	replace fr = 1 if country == "France"
}
drop count

egen count = total(country == "Italy")
display count
if (count != 0) {
	gen it = 0
	label var it "Dummy variable for Italy"
	replace it = 1 if country == "Italy"
}
drop count

egen count = total(country == "Spain")
display count
if (count != 0) {
	gen es = 0
	label var es "Dummy variable for Spain"
	replace es = 1 if country == "Spain"
}
drop count

gen be_af = be * af12
gen bg_af = bg * af12
gen cz_af = cz * af12
gen fi_af = fi * af12
gen fr_af = fr * af12
gen it_af = it * af12
gen es_af = es * af12

drop nace country

cd "/Users/hedgewang/Google Drive/carbon emissions training"
export excel using "data", firstrow(variables) replace


// estpost correlate af12 /// 
// or12–11 or11–10 or10–09 or09–08 or10 /// 
// ne12–11 ne11–10 ne10–09 ne09–08 ne10 /// 
// mining_dummy /// 
// manu_paper_dummy /// 
// manu_chemicals_dummy /// 
// manu_metal_dummy /// 
// manu_other_dummy /// 
// electricity_dummy /// 
// gas_and_steam_dummy
//
// esttab, unstack not noobs compress
//
// estpost correlate electricity_dummy /// 
// gas_and_steam_dummy
//
// esttab, unstack not noobs compress
