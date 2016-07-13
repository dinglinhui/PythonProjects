# -*- coding:UTF-8 -*-
'''
Created on Jan 22, 2016

@author: dinglinhui
'''
import os.path

if __name__ == '__main__':
    base_dir = "/cluster/storage/no-backup/coremw/var/log/saflog/sbgLog/sbgKPIsLog/"
    listfile = os.listdir(base_dir)
    listfile.sort(key=lambda fn: os.path.getmtime(base_dir + fn) if not os.path.isdir(base_dir + fn) else 0)
#     d=datetime.datetime.fromtimestamp(os.path.getmtime(base_dir+listfile[-1]))
    kpilog = open(base_dir + listfile[-1]).read()
    loglist = ''.join(kpilog.split(' ')).split('\n\n')
    print filter((lambda x:x != ''), loglist)[-1]
