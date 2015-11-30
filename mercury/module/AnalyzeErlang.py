#!/usr/bin/python
# -*-coding:utf-8-*-

'''
Created on Oct 16, 2014

@author: xdinlin
'''
import codecs
import re

class AnalyzeErlang(object):
    '''
    classdocs
    '''
    def __init__(self):
        '''
        Constructor
        '''
        self.codeList = []
        self.macroList = []
        self.funcList = []
        self.funcDetailList = []
        #
        self.InitPattern()
        
    def InitPattern(self):
        self.codePattern = re.compile(r'\A\s*[\%|\n]+')
        self.macroBeginPattern = re.compile(r'.*\-define\s*\(.*\n')
        self.oneLineMacroPattern = re.compile(r'.*\-define\s*\(.*\)\s*\.\s*\n')
        self.funPattern = re.compile(r'.*fun\s*\(.*\n')
        self.funcBeginPattern = re.compile(r'.*\)\s*\-\>\s*')
        self.endPattern = re.compile(r'.*\.\s*\n')
    
    def printFunc(self):
        for func in self.funcList:
            print ''.join(func)
            print '================================================================================'
    
    ################################################################################
    # 过滤erlang文件，去掉注视和空行
    ################################################################################
    def filterCode(self, textList):
        self.codeList = []
        for line in textList:
            # 使用Pattern匹配文本，获得匹配结果，无法匹配时将返回None
            codeMatch = self.codePattern.match(line)
            if codeMatch:
                # 使用Match获得分组信息
    #             print codeMatch.group()
                pass
            else:
#                 self.codeList.insert(len(self.codeList), line)
                self.codeList.append(line)
                
    ################################################################################
    # 过滤erlang code，提取宏和函数
    ################################################################################
    def filterMacroAndFunc(self):
        oneMacro = []
        oneFunc = []
        
        for line in self.codeList:
            # 提取宏
            if self.oneLineMacroPattern.match(line):
#                 oneMacro.insert(len(oneMacro), line)
                oneMacro.append(line)
#                 self.macroList.insert(len(self.macroList), ''.join(oneMacro).decode('utf8'))
                self.macroList.append(''.join(oneMacro).decode('utf8'))
    #             print ''.join(oneDefine)
                oneMacro = []
            else:
                if len(oneMacro) == 0:
                    if self.macroBeginPattern.match(line):
#                         oneMacro.insert(len(oneMacro), line)
                        oneMacro.append(line)
                    else:
                        pass
                else:
                    if self.endPattern.match(line):
#                         oneMacro.insert(len(oneMacro), line)
                        oneMacro.append(line)
#                         self.macroList.insert(len(self.macroList), ''.join(oneMacro).decode('utf8'))
                        self.macroList.append(''.join(oneMacro).decode('utf8'))
    #                     print ''.join(oneDefine)
                        oneMacro = []
                    else:
#                         oneMacro.insert(len(oneMacro), line)
                        oneMacro.append(line)
            
            # 提取函数
            if self.funcBeginPattern.match(line):
                if len(oneFunc) != 0:
#                     oneFunc.insert(len(oneFunc), line)
                    oneFunc.append(line)
                else:
                    if self.funPattern.match(line):
                        pass
                    else:
#                         oneFunc.insert(len(oneFunc), line)
                        oneFunc.append(line)
            else:
                if len(oneFunc) != 0:
                    if self.endPattern.match(line):
#                         oneFunc.insert(len(oneFunc), line)
                        oneFunc.append(line)
#                         self.funcList.insert(len(self.funcList), oneFunc)
                        self.funcList.append(oneFunc)
#                         self.funcList.insert(len(self.funcList), ''.join(oneFunc).decode('utf8'))
    #                     print ''.join(oneFunc)
                        oneFunc = []
                    else:
                        oneFunc.insert(len(oneFunc), line)
                else:
                    pass
                
    #     print defineList
    #     print funcList
    #     print ''.join(defineList)
    #     print ''.join(funcList)
         
    ################################################################################
    # 格式化宏
    ################################################################################
    def formatMacro(self):
        newMacroList = []
        for macro in self.macroList:
            openParan = macro.split('(')
            if len(openParan) > 0:
                # 恢复第二部分的(
                newOpenParan = []
                for i in range(1, len(openParan)):
#                     newOpenParan.insert(len(newOpenParan), openParan[i])
                    newOpenParan.append(openParan[i])
                    if i != len(openParan) - 1:
#                         newOpenParan.insert(len(newOpenParan), '(')
                        newOpenParan.append('(')
    #             print ''.join(newOpenParan)
                
                closeParan = ''.join(newOpenParan).split(')')
                if len(closeParan) > 0:
                    # 恢复第一部分的)
                    newCloseParan = []
                    for i in range(0, len(closeParan) - 1):
#                         newCloseParan.insert(len(newCloseParan), closeParan[i])
                        newCloseParan.append(closeParan[i])
                        if i != len(closeParan) - 2:
#                             newCloseParan.insert(len(newCloseParan), ')')
                            newCloseParan.append(')')
    #                 print ''.join(newCloseParan)
    #                 
                    comma = ''.join(newCloseParan).split(',')
                    if len(comma) > 0:
                        # 恢复第二部分的,                    
                        second = []
                        for i in range(1, len(comma)):
#                             second.insert(len(second), comma[i])
                            second.append(comma[i])
                            if i != len(comma) - 1:
#                                 second.insert(len(second), ',')
                                second.append(',')
#                         newMacroList.insert(len(newMacroList), [comma[0], ''.join(second)])
                        newMacroList.append([comma[0], ''.join(second)])
        
    #     print newDefineList
        self.macroList = newMacroList

    ################################################################################
    # 替换函数中的宏
    ################################################################################
    def replaceMacro(self):
        newFuncList = self.funcList
        for macro in self.macroList:
            funcList = newFuncList
            newFuncList = []
            for func in funcList:
    #             print func
#                 newFuncList.insert(len(newFuncList), func.replace('?' + ''.join(macro[0]).decode('utf8'), ''.join(macro[1]).decode('utf8')))
                newFuncList.append(func.replace('?' + ''.join(macro[0]).decode('utf8'), ''.join(macro[1]).decode('utf8')))
         
        self.funcList = newFuncList   
    #     print funcList
    #     print newFuncList
    
    def analyzeFunc(self, func):
        funcStack = []
        for line in func:
            pass
        

    def analyze(self, filename):
        # 以读方式打开文件，rb为二进制方式(如图片或可执行文件等)
        filehandler = codecs.open(filename, 'r', "utf-8")    
        
        # 返回文件头
        filehandler.seek(0)
        self.filterCode(filehandler.readlines())
        self.filterMacroAndFunc()
        self.formatMacro()
#         self.replaceMacro()
        self.printFunc()
        
        for func in self.funcList:
            self.analyzeFunc(func)
        
        # 关闭文件句柄
        filehandler.close() 
