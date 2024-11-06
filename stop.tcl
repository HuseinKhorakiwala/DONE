set num_nodes 2
set ns [new Simulator]
set nf [open out_sr.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out_sr.nam &
exit 0
}
set node1 [$ns node]
set node2 [$ns node]
$ns duplex-link $node1 $node2 1Mb 10ms DropTail
set window_size 1
set num_packets 10
set packet_size 500
set tcp [new Agent/TCP]
$tcp set window_ 1
$ns attach-agent $node1 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $node2 $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set packetSize_ 500
$ftp set maxpkts_ 10
$ns at 0.5 "$ftp start"
$ns at 10.0 "finish"
$ns run
