$targetservers = "TC-NAS03.aetcom.local"

$ports = "22","7","9","13","21","22","23","25","26","37","53","79","80","81","88","106","110","111","113","119","135","139","143","144","179","199","389","427","443","445","465","513","514","515","543","544","548","554","587","631","646","873","990","993","995","1025","1029","1110","1433","1720","1723","1755","1900","2000","2001","2049","2121","2717","3000","3128","3306","3389","3986","4899","5000","5009","5051","5060","5101","5190","5357","5432","5631","5666","5800","5900","5985","5986","6000","6001","6646","7070","8000","8008","8009","8080","8081","8443","8888","9100","9999","10000","32768","49152","49155","49157"

$result = @()

foreach ($target in $targetservers) {

    foreach ($port in $ports) {

        $obj = new-Object system.Net.Sockets.TcpClient

        $connect = $obj.BeginConnect($target,$port,$null,$null)

        $Wait = $connect.AsyncWaitHandle.WaitOne(100,$false)

        If (-Not $Wait) {

            #write-host $target 'port' $port 'Closed - Timeout'

        }

        else {

            $value = "Open"

            write-host $target 'port' $port $value

            $r = new-object -type psobject

            $r | add-member -membertype noteproperty -name host -value $target

            $r | add-member -membertype noteproperty -name port -value $port

            $r | add-member -membertype noteproperty -name state -value $value

            $result += $r

        }

    }

}
