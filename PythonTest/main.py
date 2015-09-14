#!/usr/bin/python
# -*-coding:utf-8-*-

from analysis import AnalyzeErlang
# from symbol import except_clause

if __name__ == '__main__':
    
    analysor = AnalyzeErlang()
    analysor.analyze('sbg_ft_media_source_filtering_SUITE.erl')
    
# # case: if 
#     love = 'i love python'
#     if 'python' in love:
#         print love
# 
# # case: for
#     for i in love:
#         print i

# case: while
#     while True:
#         reply = raw_input('Enter text:')
#         if reply == 'stop':break
# #         elif not reply.isdigit(): print reply.upper() * 2
# #         else: print int(reply) ** 2
#         try:
#             num = int(reply)
#         except:
#             print 'Bad!' * 8
#         else:
#             print int(reply) ** 2

#     spam = 'Spam'
#     print spam
#     
#     spam, ham = 'yum', 'YUM'
#     print spam, ham
#     
#     (a, b) = ('a', 'b')
#     print a, b
#     [c, d] = ['a', 'b']
#     print c, d
#     a, b, c, d = 'abcd'
#     print a, b, c, d


#     L = [1,2,3,4]
#     while L:
# #         front, *L = L python 3
#         front, L = L[0], L[1:]
#         print front, L
    