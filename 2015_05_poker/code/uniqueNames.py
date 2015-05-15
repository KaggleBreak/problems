#!/usr/bin/python

import re
import os

def createNamesDatabase(*names):
    """
    >>> db = createNamesDatabase("abc", "123", "abc123", "abc_123")
    >>> "abc" in db
    True
    >>> "abc123" in db
    True
    >>> "abC123" in db
    False
    """
    result = set()
    for arg in names:
        if(isinstance(arg, str)):
           result.add(arg)
        else:
            try:
                result.add(set(arg))
            except:
                result.add(str(arg))
    return result


def addToNamesDatabase(db, *names):
    for arg in names:
        if(isinstance(arg, str)):
           db.add(arg)
        else:
            try:
                db.add(set(arg))
            except:
                db.add(str(arg))

def splitName(name, numPattern=r'[0-9]+', delimPattern=r'[-._]+'):
    parts = re.split("("+delimPattern+")", name)
    moreParts = []
    indexOfNums = []
    for part in parts:
        x = re.split("("+numPattern+")", part)
        for p in  x:
            if(re.match(numPattern, p)):
                indexOfNums.append(len(moreParts))
            moreParts.append(p)
    return moreParts, indexOfNums

def incrementName(name, numPattern=r'[0-9]+', delimPattern=r'[-._]+', numDigits=4, defaultDelim="_"):
    parts, nums = splitName(name)
    if(len(nums)==0):
        return incrementName(name + defaultDelim + ("0"*numDigits), numPattern, delimPattern, numDigits, defaultDelim)
    i = nums[-1]
    l = len(parts[i])
    parts[i] = str(int(parts[i]) + 1)
    while(len(parts[i])<l):
        parts[i] = "0" + parts[i]
    return "".join(parts)

def uniquifyName(name, db, numPattern=r'[0-9]+', delimPattern=r'[-._]+', numDigits=4, defaultDelim="_"):
    """
    >>> db = createNamesDatabase("abc", "123", "abc123", "abc_123", "xyz_123_abc")
    >>> uniquifyName("123", db)
    '124'
    >>> uniquifyName("123", db)
    '125'
    >>> uniquifyName("123", db)
    '126'
    >>> uniquifyName("127", db)
    '127'
    >>> uniquifyName("xyz_123_abc", db)
    'xyz_124_abc'
    >>> uniquifyName("abc", db)
    'abc_0001'
    """
    n = name
    while(n in db):
        n = incrementName(n)
    addToNamesDatabase(db, n)
    return n

def generateUniqueFilename(path):
    if(not os.path.exists(path)):
        return path
    base = os.path.basename(path)
    directory = os.path.dirname(path)
    root, ext = os.path.splitext(base)
    files = os.listdir(directory)
    
    if(not re.search(r'[0-9]+', root)):
        root += "_0000"
    db = createNamesDatabase()
    for f in files:
        b = os.path.basename(f)
        r, e = os.path.splitext(b)
        addToNamesDatabase(db, r)
    return os.path.join(directory, uniquifyName(root, db)+ ext)
        
                
def _test():
    import doctest
    doctest.testmod()

if __name__ == "__main__":
    _test()        


