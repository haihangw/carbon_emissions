
# Reproducibility Appendix: The Impact of the EU ETS on the Competitiveness and Employment of Firms in the Second Trading Period

The project is a part of my senior [thesis](thesis/). It intends to explore 
how the 
relative allocation of allowances in the EU ETS impacted the competitveness and employment of firms covered by the EU ETS in the second trading period. This README.md file will go over the process of extracting emissions data from the European Union Community Transaction Log, downloading company-level data (NACE code, Revenue data, and No. employment data) from Orbis by Bureau van Dijk, and performing the empirical analysis in my senior thesis. 

## Getting Started

Cloning the repository to your local directory: 
```
git clone https://github.com/ricardowang/carbon_emissions
```
### Prerequisites
Make sure you have Python downloaded and set up on your computer and the required packages installed. 
```
pip install requests Scrapy
```
### Installing
If you use Python 2.x, go to [version 2](https://github.com/ricardowang/carbon_emissions/tree/master/Python%20Code/Python%202.x) to download the code for extracting emissions data. If you use Python 3.x, go to [version 3](https://github.com/ricardowang/carbon_emissions/tree/master/Python%20Code/Python%203.x) instead. 
You can check the version of Python by running: 
```
python --version
```
Replace the line in the code with your working directory where you want to save the .csv files: 
```
directory = ''
```
Go to the directory where you put your Python script, and then run the Python script depending on the version you have downloaded: 
```
python emissions_data_mining_version_2.py
```
Or 
```
python emissions_data_mining_version_3.py
```
Note: due to the sheer volume of the emissions data, it might take at least two hours to download all data. 

## Step-by-step Guide on How to Replicate the Results
### 1. Extracting emissions data from the European Union Community Transaction Log: 
```
[ADD MORE]
```
## Authors

* **Haihang Wang**, [University of Michigan](https://www.umich.edu), haihangw@umich.edu 
- *Initial work* - [carbon_emissions](https://github.com/ricardowang/carbon_emissions)

## Acknowledgments
* I am especially grateful to my thesis advisor, Professor Kathryn M. 
Dominguez, for her invaluable advice and continued guidance. 
* I would like to thank Professor William J. Adams for his insightful 
comments. 
* I would also like to thank Tian Yang for his generous help on extracting 
emissions data from the European Union Community Transaction Log. 
* I give my thanks to Josh Anderson from Bureau van Dijk for his help on the 
Orbis database. 
* Finally, I would like to thank Aidan Parker, Subramanian Ramanujam, Quan 
Du, and all of my peers in Econ 495 (Section 001, Fall 2017) for their helpful suggestions. 
