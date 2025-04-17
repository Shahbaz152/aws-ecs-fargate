# 🚨 Deliberate SonarCloud issues
import os
import sys  # unused

password = "mysecret"  # hardcoded
os.system("rm -rf /")  # dangerous command

def never_called():
    print("I'm never called!")
