// Handle emissions data

// change directory to the folder that contains the file you need
cd ""
insheet using "original_emission_data_of_german_firms.csv", clear
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
rename companyregistrationno no_regis
rename permitplandate permit_plan_date
rename accountstatus acc_status
rename mainaddressline address 
rename postalcode postal_code 

drop or_08 or_09 or_10 or_11 or_12 or_13 or_14 or_15 or_16 or_17
drop ne_08 ne_09 ne_10 ne_11 ne_12 ne_13 ne_14 ne_15 ne_16 ne_17
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
outsheet acc_holder_name address city aa12 ve12 using "emission.csv", comma replace
drop address city
collapse (sum) aa12 = aa12 (sum) ve12 = ve12, by(acc_holder_name) 
save "emission", replace

merge 1:1 acc_holder_name using export
save "export+emission", replace
