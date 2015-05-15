#!/usr/bin/python

from sklearn import svm
from numpy import genfromtxt, savetxt
import uniqueNames

def main():
    clf = svm.SVC(gamma=0.001, C=100)    

    #create the training & test sets, skipping the header row with [1:]
    dataset = genfromtxt(open('Data/trainPrep.csv','r'), delimiter=',', dtype='f8')[1:]    
    target = [x[-1] for x in dataset]
    train = [x[:-1] for x in dataset]
    test = genfromtxt(open('Data/testPrep.csv','r'), delimiter=',', dtype='f8')[1:]
    test =  [x[1:] for x in test]

    svc=clf.fit(train, target)

    predicted = []
    i = 1
    for x in test:
        y = clf.predict(x)
        predicted.append([i,y])
        i += 1
        
    filename = uniqueNames.generateUniqueFilename("Data/submission.csv")
    print "Generating submission: " + filename
    savetxt(filename, predicted, delimiter=',', fmt='%d,%d', 
            header='id,hand', comments = '')

if __name__=="__main__":    
    main()
