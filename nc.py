#!/usr/bin/env python

import socket
import sys

import threading
import time

exitFlag = 0

class myThread(threading.Thread):
   def __init__(self, threadID, name):
      threading.Thread.__init__(self,daemon=True)
      self.threadID = threadID
      self.name = name
   def run(self):
      sendLoop()

def receiveLoop():
    while True:
        data = sock.recv(4096)
        if len(data) == 0:
            print("socket closed by remote end")
            break
        else:
            print(str(data))

def sendLoop():
    while True:
        myinput = input()
        sock.sendall(bytes(myinput+"\n",'utf-8'))

def usage():
    print("nc.py ADDRESS PORT")

if len(sys.argv)!=3:
    usage()
    sys.exit()

sock = socket.socket()
sock.connect((sys.argv[1],int(sys.argv[2])))
print("Connected")

# Create new threads
thread1 = myThread(1, "Thread-1")

# Start sendThread
thread1.start()

receiveLoop()
