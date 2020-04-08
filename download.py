import sys


urllib2import = True
wgetimport = True
requestsimport = True

def usage():
    print("download.py [URL] [FILENAME]")

if len(sys.argv) < 3:
    print("Missing Arguments")
    usage()
    sys.exit(1)

url = sys.argv[1]
filename = sys.argv[2]

try:
    import urllib2
except ImportError:
    print("urllib2 not found")
    urllib2import = False

try:
    import requests
except ImportError:
    print("requests not found")
    requestsimport = False

try:
    import wget
except ImportError:
    print("wget not found")
    wgetimport = False

if urllib2import == True:
    print("Downloading with urllib2")
    #With urllib2
    filedata = urllib2.urlopen(url)
    datatowrite = filedata.read()
    with open(filename,'wb') as fd:
        fd.write(datatowrite)
    print("Done")
    sys.exit(0)

if requestsimport == True:
    print("Downloading with requests")
    #With requests
    myfile = requests.get(url)
    datatowrite = myfile.content
    with open(filename,'wb') as fd:
        fd.write(datatowrite)
    print("Done")
    sys.exit(0)

if wgetimport == True:
    print("Downloading with wget")
    #With wget
    wget.download(url, filename)
    print("Done")
    sys.exit(0)


print("No suitable module found. I suggest to install one of them")
sys.exit(1)

