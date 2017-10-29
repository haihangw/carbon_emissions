// OLS 
// Relative allocation on firms' competitveness as measured by change in revenues 
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
gas_and_steam_dummy, robust

// Test: Excluding insignificant variables 
test (or11–10 = 0) (or10–09 = 0) ///
(or09–08 = 0) (mining_dummy = 0) ///
(manu_paper_dummy = 0) (manu_chemicals_dummy = 0) ///
(manu_metal_dummy = 0) (manu_other_dummy = 0) ///
(electricity_dummy = 0) (gas_and_steam_dummy = 0)

// On significant variables
regress or12–11 /// 
af12 /// 
or10 ne10 /// 
ne11–10, robust


// Relative allocation on firms' employment 
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
gas_and_steam_dummy, robust 

// Test: Excluding insignificant variables 
test (ne10–09 = 0) (ne09–08 = 0) ///
(or11–10 = 0) (mining_dummy = 0) /// 
(manu_paper_dummy = 0) (manu_metal_dummy = 0) ///
(manu_other_dummy = 0) (electricity_dummy = 0) ///
(gas_and_steam_dummy = 0) 

// On significant variables 
reg ne12–11 /// 
af12 /// 
ne11–10 /// 
ne10 or10 /// 
manu_chemicals_dummy, robust
