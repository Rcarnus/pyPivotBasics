import urllib2
import sys

def usage():
    print("download.py [URL] [FILENAME]")

if len(sys.argv) < 3:
    print("Missing Arguments")
    usage()
    sys.exit(1)

url = sys.argv[1]
filename = sys.argv[2]

filedata = urllib2.urlopen(url)
datatowrite = filedata.read()

with open(filename,'wb') as fd:
    fd.write(datatowrite)
