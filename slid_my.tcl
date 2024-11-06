set ns [new Simulator]

set nf [open s1.nam w]
$ns namtrace-all $nf

set nf1 [open s1.tr w]
$ns trace-all $nf1

proc finish {} {
global ns nf nf1
$ns flush-trace

close $nf
close $nf1

exec nam s1.nam &
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n1 $n4 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail
$ns duplex-link $n5 $n6 1Mb 10ms DropTail
$ns duplex-link $n5 $n7 1Mb 10ms DropTail
$ns duplex-link $n6 $n8 1Mb 10ms DropTail
$ns duplex-link $n7 $n9 1Mb 10ms DropTail

$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n1 $n4 orient right-down
$ns duplex-link-op $n3 $n4 orient right-up
$ns duplex-link-op $n4 $n5 orient right
$ns duplex-link-op $n5 $n6 orient right-up
$ns duplex-link-op $n5 $n7 orient right-down
$ns duplex-link-op $n6 $n8 orient right
$ns duplex-link-op $n7 $n9 orient right

set udp0 [new Agent/UDP]
$ns attach-agent $n2 $udp0
$udp0 set fid_ 1

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n9 $null0

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
$tcp0 set fid_ 2

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set tcpsink0 [new Agent/TCPSink]
$ns attach-agent $n8 $tcpsink0

$ns connect $udp0 $null0
$ns connect $tcp0 $tcpsink0

$ns color 1 Red
$ns color 2 Blue

$ns at 0.5 "$cbr0 start"
$ns at 2.5 "$cbr0 stop"
$ns at 3.0 "$ftp0 start"
$ns at 4.5 "$ftp0 stop"
$ns at 5.0 "finish"

$ns run

