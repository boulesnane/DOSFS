# DOSFS: Dynamic Online Streaming Feature Selection

Feature selection is a key issue in machine learning and data mining. A great deal of effort has been devoted to static feature selection. However, with the assumption that features occur over time, methods developed so far are difficult to use if not applicable. Therefore, there is a need to design new methods to deal with streaming feature selection (SFS). In this paper, we propose the use of dynamic optimization to handle the dynamic nature of SFS with the ultimate goal to improve the quality of the evolving subset of selected features. A hybrid model is developed to fish out relevant features set as unnecessary by an online feature selection process. Experimental results show the effectiveness of the proposed framework compared to some state of the art methods.

# Motivation
Motivated by the fact that the problem of online feature selection is a dynamic problem whose dimension (feature) changes over time, we propose a hybridization between the dynamic optimization algorithms and the Online Streaming Feature Selection algorithm (OSFS) (https://github.com/kuiy/LOFS), whose objective is to find a subset of optimal attributes to ensure better classification of unclassified data. 

# Requirements
Weka

https://people.kyb.tuebingen.mpg.de/spider/

# Example of run

The main file is : DOFS.m, so just run it after that you will get the following interface:

<img src="/screenshot/capturedosfs.PNG">

From this GUI you can specify what Data you will use by selecting the train data file and the test data file from your computer,
<img src="/screenshot/data1.PNG">

or you can just select a complete DATA file and split it to train and test files by entering the right percent value and press ok button :
<img src="/screenshot/data2.PNG">

Note : it is important to firstly select the type of the used data: discrete or continuous.

Afterwards, we select what objectif function we will use in our dynamic optimization algorithm (1-Filter;  FisherZ or MI,  2-KNN).
Then, we select the used OFSA algorithm and the dynamic optimization algorithm (Dynamic PSO, WD2O).
In order to evaluate a selected feature subset in the experiments,  SVM or KNN classifiers  are used.

# Reference
Please reference this work as follows: 

Abdennour Boulesnane and Souham Meshoul. "Effective Streaming Evolutionary Feature Selection Using Dynamic Optimization." IFIP International Conference on Computational Intelligence and Its Applications. Springer, Cham, 2018.
# link
https://link.springer.com/chapter/10.1007%2F978-3-319-89743-1_29

Copyright © 2021 Abdennour Boulesnane and Souham Meshoul
