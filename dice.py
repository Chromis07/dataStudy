a=[1,2,3,4,5,6]
b=[1,2,3,4,5,6]

n = int(input())
# list comprehension 2중 for문
list = [[i, j] for i in a 
        for j in b
        if i+j == n]

# for i in a:
#     for j in b:
#         if i+j == n:
#             list.append([i, j])
#     print()

for j in range(len(list)):
    print(f'{list[j][0]} {list[j][1]}')

for row in list:
    for column in row:
        print(column, end=" ")
    print()