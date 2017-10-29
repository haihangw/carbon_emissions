// Handle economic data

// change directory to the folder that contains the file you need
cd ""
insheet using "export.csv", clear
drop v1
rename company acc_holder_name
rename streetnobuildingetcline1 address
duplicates list acc_holder_name
drop if missing(acc_holder_name)
save "export", replace
