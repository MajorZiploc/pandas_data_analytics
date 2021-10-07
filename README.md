# Purpose
An area for exploratory data science; to clean, analyze, and visualize data. 

Data sources vary from kaggle.com and personally web scrapped. Formats vary from csv, excel, json, and sql.

# Data
The data sources are generally ignored by git.

Some are from kaggle and the config.toml of most of the projects will mention the url the data is from.

Some of the data is personally scrapped using webscrapper.io. See my web_scraper_io_scripts repo for how to scrap this
data yourself.

# Dependencies:
- pip
- python v3.8

# Development Dependencies
- just (command runner) v0.10.0

# Development Tools:
- vscode
- vscode plugins
  - almenon.arepl
  - ms-python.python
  - ms-toolsai.jupyter
  - ms-python.vscode-pylance

# First time setup

> just first-time-initialize;
> . $HOME/.virtualenvs/pandas_data_analytics/bin/activate;

OR

for windows:
> just first-time-initialize-windows;
> . $HOME/.virtualenvs/pandas_data_analytics/Scripts/activate;

# Project setup and use
View the Justfile for bash commands. If you have just installed, then you can run the commands from bash with:

> just {command}

Else you will need to copy the commands into bash

## Run some code
Make sure you are in the virtual environment and have the pip dependencies installed

> python <./path/to/file>

setup.py with the follow line of code is required for references project files in other project files for import statements
packages=find_packages(include=['pandas_data_analytics', 'pandas_data_analytics.*']),

# Interactive qtconsole shell
> $ jupyter qtconsole
## loading a python file into the interactive
> in qtconsole ---> %run <path/to/pythonfile>

# Cool Packages
## Data Science
<table style="width:100%">
  <tr>
    <th>Package</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>pandas</td>
    <td>dataframe</td>
  </tr>
  <tr>
    <td>dask</td>
    <td>chunks pandas dataframes for scaling. async utils aswell</td>
  </tr>
  <tr>
    <td>sklearn</td>
    <td>machine learning models</td>
  </tr>
  <tr>
    <td>scikit-learn</td>
    <td>sklearn helper</td>
  </tr>
  <tr>
    <td>scikit-mdr</td>
    <td>sklearn helper</td>
  </tr>
  <tr>
    <td>skrebate</td>
    <td>sklearn helper</td>
  </tr>
  <tr>
    <td>numpy</td>
    <td>math lib</td>
  </tr>
  <tr>
    <td>scipy</td>
    <td>math lib</td>
  </tr>
  <tr>
    <td>xgboost==1.1.0</td>
    <td>gpu</td>
  </tr>
  <tr>
    <td>nltk</td>
    <td>Natural Language Toolkit</td>
  </tr>
</table>

## Data Visualization
<table style="width:100%">
  <tr>
    <th>Package</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>seaborn</td>
    <td>charting</td>
  </tr>
  <tr>
    <td>plotly</td>
    <td>charting</td>
  </tr>
  <tr>
    <td>cufflinks</td>
    <td>charting</td>
  </tr>
</table>

## Utilities
<table style="width:100%">
  <tr>
    <th>Package</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>joblib</td>
    <td>Pickling python Objects</td>
  </tr>
  <tr>
    <td>toml</td>
    <td>Config files</td>
  </tr>
  <tr>
    <td>pdpipe</td>
    <td>ml pipeline helper</td>
  </tr>
  <tr>
    <td>openpyxl</td>
    <td>read excel</td>
  </tr>
  <tr>
    <td>py-linq</td>
    <td>LINQ in python</td>
  </tr>
  <tr>
    <td>pdfplumber</td>
    <td>pdf reader</td>
  </tr>
</table>

## Interactive (all required for launching an interactive shell)
<table style="width:100%">
  <tr>
    <th>Package</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>jupyter</td>
    <td>interactive data science</td>
  </tr>
  <tr>
    <td>jupyter-contrib-nbextensions</td>
    <td>plugin support for jupyter</td>
  </tr>
  <tr>
    <td>qtconsole</td>
    <td>python interactive</td>
  </tr>
  <tr>
    <td>pyqt5</td>
    <td>for qtconsole</td>
  </tr>
</table>
