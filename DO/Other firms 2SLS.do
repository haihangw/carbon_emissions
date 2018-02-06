// 2SLS 
use combined, replace

// first stage
regress af12 or12 ne12, noconstant robust
predict af12_hat

// Relative allocation on firms' competitveness as measured by change in revenues 
regress or12–11 /// 
af12_hat /// 
or11–10 or10–09 or09–08 ///
or10 ne10 /// 
ne11–10 /// 
mining_dummy /// 
manu_paper_dummy /// 
manu_chemicals_dummy /// 
manu_metal_dummy /// 
manu_other_dummy /// 
electricity_dummy /// 
gas_and_steam_dummy

// Test: Excluding insignificant variables
test (or10–09 = 0) (mining_dummy = 0) /// 
(manu_paper_dummy = 0) (manu_chemicals_dummy = 0) ///
(manu_metal_dummy = 0) (manu_other_dummy = 0) /// 
(electricity_dummy = 0) (gas_and_steam_dummy = 0)

// On significant variables
regress or12–11 /// 
af12_hat /// 
or11–10 or09–08 ///
or10 ne10 /// 
ne11–10, robust


// Relative allocation on firms' employment 
reg ne12–11 /// 
af12_hat /// 
ne11–10 ne10–09 ne09–08 ///
ne10 or10 /// 
or11–10 /// 
mining_dummy /// 
manu_paper_dummy /// 
manu_chemicals_dummy /// 
manu_metal_dummy /// 
manu_other_dummy /// 
electricity_dummy /// 
gas_and_steam_dummy, robust

// Test: Excluding insignificant variables 
test (ne11–10 = 0) (ne10–09 = 00) /// 
(or11–10 = 0) (mining_dummy = 0) /// 
(manu_paper_dummy = 0) (manu_metal_dummy = 0) /// 
(manu_other_dummy = 0) (electricity_dummy = 0) /// 
(gas_and_steam_dummy = 0)

// On significant variables 
reg ne12–11 /// 
af12_hat /// 
ne09–08 /// 
ne10 /// 
or10, robust

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

regress or12–11 /// 
af12_hat /// 
or11–10 or10–09 or09–08 ///
or10 ne10 /// 
ne11–10 /// 
mining_dummy /// 
manu_paper_dummy /// 
manu_chemicals_dummy /// 
manu_metal_dummy /// 
manu_other_dummy /// 
electricity_dummy /// 
gas_and_steam_dummy /// 
bg /// 
cz /// 
fi /// 
fr /// 
it /// 
es, robust

test (bg = 0) (cz = 0) (fi = 0) (fr = 0) (it = 0) (es = 0)

gen be_af = be * af12_hat
gen bg_af = bg * af12_hat
gen cz_af = cz * af12_hat
gen fi_af = fi * af12_hat
gen fr_af = fr * af12_hat
gen it_af = it * af12_hat
gen es_af = es * af12_hat

gen af12_hat2 = af12_hat * 1000

regress or12–11 /// 
af12_hat2 /// 
or11–10 or10–09 or09–08 ///
or10 ne10 /// 
ne11–10 /// 
mining_dummy /// 
manu_paper_dummy /// 
manu_chemicals_dummy /// 
manu_metal_dummy /// 
manu_other_dummy /// 
electricity_dummy /// 
gas_and_steam_dummy /// 
bg /// 
cz /// 
fi /// 
fr /// 
it /// 
es /// 
bg_af /// 
cz_af /// 
fi_af /// 
fr_af /// 
it_af /// 
es_af, robust

test (bg = 0) (cz = 0) (fi = 0) (fr = 0) (it = 0) (es = 0)

test (bg_af = 0) (cz_af = 0) (fi_af = 0) (fr_af = 0) (it_af = 0) (es_af = 0)


reg ne12–11 /// 
af12 /// 
ne11–10 ne10–09 ne09–08 ///
ne10 or10 /// 
or11–10 /// 
mining_dummy ///
manu_paper_dummy /// 
manu_chemicals_dummy /// 
manu_metal_dummy /// 
manu_other_dummy /// 
electricity_dummy /// 
gas_and_steam_dummy /// 
bg /// 
cz /// 
fi /// 
fr /// 
it /// 
es /// 
bg_af /// 
cz_af /// 
fi_af /// 
fr_af /// 
it_af /// 
es_af, robust

test (bg = 0) (cz = 0) (fi = 0) (fr = 0) (it = 0) (es = 0)

test (bg_af = 0) (cz_af = 0) (fi_af = 0) (fr_af = 0) (it_af = 0) (es_af = 0)

// regress or12–11 /// 
// af12 /// 
// or11–10 or10–09 or09–08 ///
// or10 ne10 /// 
// ne11–10 /// 
// mining_dummy /// 
// manu_paper_dummy /// 
// manu_chemicals_dummy /// 
// manu_metal_dummy /// 
// manu_other_dummy /// 
// electricity_dummy /// 
// gas_and_steam_dummy /// 
// bg /// 
// cz /// 
// fi /// 
// fr /// 
// it /// 
// es, robust
//
// test (bg = 0) (cz = 0) (fi = 0) (fr = 0) (it = 0) (es = 0)

gen be_af2 = be * af12
gen bg_af2 = bg * af12
gen cz_af2 = cz * af12
gen fi_af2 = fi * af12
gen fr_af2 = fr * af12
gen it_af2 = it * af12
gen es_af2 = es * af12

regress or12–11 /// 
af12 /// 
or11–10 or10–09 or09–08 ///
or10 ne10 /// 
ne11–10 /// 
mining_dummy /// 
manu_paper_dummy /// 
manu_chemicals_dummy /// 
manu_metal_dummy /// 
manu_other_dummy /// 
electricity_dummy /// 
gas_and_steam_dummy /// 
bg /// 
cz /// 
fi /// 
fr /// 
it /// 
es /// 
bg_af2 /// 
cz_af2 /// 
fi_af2 /// 
fr_af2 /// 
it_af2 /// 
es_af2, robust
//
// test (bg = 0) (cz = 0) (fi = 0) (fr = 0) (it = 0) (es = 0)
//
// test (bg_af2 = 0) (cz_af2 = 0) (fi_af2 = 0) (fr_af2 = 0) (it_af2 = 0) (es_af2 = 0)

