import socket

s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
print("Socket created")

s.bind(("localhost",9999))
s.listen(3)
print("Waiting For Connection")

while True:
	c,addr=s.accept()
	name=c.recv(1024).decode()
	print("Successfully connected to ",addr,name)
	c.send(bytes("Hello and welcome",'utf-8'))
	c.close()
