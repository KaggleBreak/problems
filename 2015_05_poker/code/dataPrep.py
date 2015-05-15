#!/usr/bin/python

from numpy import genfromtxt, savetxt

def histogram(l):
    h={}
    for x in l:
        if x in h:
            h[x]+=1
        else:
            h[x] = 1
    return h

def hOfH(l, size=None):
    h = histogram(l)
    h = histogram(dict.values(h))
    result = dict.values(h)
    result.sort(reverse=True)
    if(size is not None):
        while(len(result)<size):
            result += [0]
        while len(result) > size:
            result.pop()
    return result


def handToFeatures(hand):
    suits = [hand[0], hand[2], hand[4], hand[6], hand[8]]
    ranks = [hand[1], hand[3], hand[5], hand[7], hand[9]]
    sh = hOfH(suits, 4)

    flush = int(sh[0] == 1 and sh[1] == 0)

    h = dict.values(histogram(ranks))
    h.sort(reverse=True)
    kind1 = h[0]
    kind2 = h[1]

    ranks.sort()
    if(1 in ranks):
        high = 1
        low = ranks[0]
        if low == 1:
            low = ranks[1]
    else:
        high = ranks[-1]
        low = ranks[0]

    normalized = [(r - low + 13)%13 for r in ranks]
    normalized.sort()
    straight = normalized[-1]==4

    return [flush, kind1, kind2, high, low, straight]


def main():
    #create the training & test sets, skipping the header row with [1:]
    train = genfromtxt(open('Data/train.csv','r'), delimiter=',', dtype='f8')[1:]   

    test = genfromtxt(open('Data/test.csv','r'), delimiter=',', dtype='f8')[1:]

    ptrain = []
    for x in train:
        y = x[-1]
        f = handToFeatures(x[:-1])
        ptrain.append(f+[y])
    
    savetxt("Data/trainPrep.csv",ptrain, delimiter=',', fmt='%d,%d,%d,%d,%d,%d,%d', 
            header='flush,kind1,kind2,high,low,straight,hand', comments = '')


    ptest = []
    for x in test:
        f = handToFeatures(x[1:])
        id = x[0]
        ptest.append([id]+f)

    savetxt("Data/testPrep.csv",ptest, delimiter=',', fmt='%d,%d,%d,%d,%d,%d,%d', 
            header='id,flush,kind1,kind2,high,low,straight', comments = '')
    
    
if __name__=="__main__":
    main()
