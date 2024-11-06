#1. `Address Family`:
#socket.AF_INET: This is the most common address family, used for IPv4 addresses.
#socket.AF_INET6: This is for IPv6 addresses.
#socket.AF_UNIX: This is for Unix domain sockets, which are used for inter-process communication on the same machine.
#2. `Socket Type`:
#socket.SOCK_STREAM: This is for TCP (Transmission Control Protocol) sockets, which provide reliable, connection-oriented communication.
#socket.SOCK_DGRAM: This is for UDP (User Datagram Protocol) sockets, which provide connectionless, unreliable communication.

#eg. s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# type of network(ipv4/ipv6) #transmission mode (TCP/UDP) 
#default tcp ipv4
print("socket created")

s.bind(('localhost',9999))# free port
s.listen(3)#wait for how many connections ie buffer for 3 connections
print("Waiting for connection")

while True:
    c,addr =s.accept()# accept the connection it give the client Scoket(c) and the address of the client
    name =c.recv(1024).decode()
    print("Connected with",addr,name)
    c.send(bytes("Welcome AND Hello",'utf-8'))
    c.close
    