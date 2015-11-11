#!/usr/bin/env python
# vim: set fileencoding=utf-8 :
#
# Created:  2015-11-11
#

import Orange
def execute():
    data = Orange.data.Table('track.basket')

    # 支持度(support)が 0.01 以上、信頼度(confidence)が 0.2 以上のルールを抽出
    rules = Orange.associate.AssociationRulesSparseInducer(data, support=0.01, confidence=0.2)

    # 結果の出力
    # "%4s %4s %4s  %4s" % ("Supp(支持度)", "Conf(信頼度)", "Lift(リフト値)", "Rule(アソシエーションルール)")
    with open("associates.csv", "w") as file:
        for r in rules[:5]:
            left, right =  str(r).split("->")
            file.write("%4.1f,%4.1f,%4.1f,%s,%s\n" % (r.support, r.confidence, r.lift, left.strip(), right.strip()))

if __name__ == "__main__":
    execute()
