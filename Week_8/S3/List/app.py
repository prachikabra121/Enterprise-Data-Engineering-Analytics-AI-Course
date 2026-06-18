n= 5
for i in range(1,n+1,1):
    if i == 1:
        print((n-i) * ' '+ "* ")
    else:
        print((n-i)* ' ' +'* '+(i-2) *' '+'* ' )