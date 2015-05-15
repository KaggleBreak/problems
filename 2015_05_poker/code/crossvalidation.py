#!/usr/bin/python

from sklearn.ensemble import *
from sklearn import svm
from sklearn import cross_validation
import logloss
import numpy as np

def main():
    classifier = GradientBoostingClassifier
    #read in  data, parse into training and target sets
    dataset = np.genfromtxt(open('Data/trainPrep.csv','r'), delimiter=',', dtype='f8')[1:]    
    target = np.array([x[-1] for x in dataset])
    train = np.array([x[:-1] for x in dataset])

    #In this case we'll use a random forest, but this could be any classifier
    cfr = classifier()

    #Simple K-Fold cross validation. 5 folds.
    cv = cross_validation.KFold(len(train), n_folds=5, shuffle=True)

    #iterate through the training and test cross validation segments and
    #run the classifier on each one, aggregating the results into a list
    results = []
    for traincv, testcv in cv:
        predicted = cfr.fit(train[traincv], target[traincv]).predict(train[testcv])
        total=len(predicted)
        correct=0.0
        for i in range(total):
            if target[testcv][i] == predicted[i]:
                correct += 1.0
        results.append(correct/total)

    #print out the mean of the cross-validated results
    print "Results: " + str( np.array(results).mean() )

if __name__=="__main__":
    main()
