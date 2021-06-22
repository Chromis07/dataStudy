import math
count = 1
list = []


while count <= 6 :
	n = int(input())
	list.append(n)
	count += 1

list_total = [i for i in list if int(math.sqrt(i)) == math.sqrt(i)]
#for i in list :
#	if math.sqrt(i)**2 == i :
#		list_total.append(i)
print(len(list_total))