'''
Created on Feb 15, 2015

@author: dlh
'''

class MyNunber(object):
    '''
    classdocs
    '''


    def __init__(self, params):
        '''
        Constructor
        '''
        
    def numToString(self, num):
        ret = ''
        num = int(num)
        if num / 10000 == 0:
            ret = str(num)
        else:
            if num / 10 ** 8 == 0:
                if num % 10000 != 0:
                    ret = str(num / 10000) + '万' + str(num % 10000)
                else:
                    ret = str(num / 10000) + '万'
            else:
                n2 = num % 10 ** 8
                if n2 % 10000 != 0 and n2 / 10000 != 0:
                    ret = str(num / 10 ** 8) + '亿' + str(n2 / 10000) + '万' + str(n2 % 10000)
                elif  n2 % 10000 != 0 and n2 / 10000 == 0:
                    ret = str(num / 10 ** 8) + '亿' + str(n2 % 10000)
                elif  n2 % 10000 == 0 and n2 / 10000 != 0:
                    ret = str(num / 10 ** 8) + '亿' + str(n2 / 10000) + '万'
                elif  n2 % 10000 == 0 and n2 / 10000 == 0:
                    ret = str(num / 10 ** 8) + '亿'
        return ret