//эта тупая программа отняла у меня кучу времени, но она вес равно рисует не совсем правильный ррегольник
from itertools import combinations
class Figure():
 def __init__(self, m):
 if not m:
 m = self.matrix()
 self.m = m
 def matrix(self):
 self.m = [['.' for _ in range(50)] for _ in range(50)]
 return self.m
 def printing(self):
 for i in range(len(self.m)):
 for j in range(len(self.m)):
 print(self.m[i][j], end='')
 print()

 def drawDia(self, a1, b1, a2, b2):

 self.m[b1][a1]='*'

 if a1==a2 or b1==b2:
 #прямая
 if a1 == a2:
 for i in range(min(b1,b2), max(b1, b2) + 1):
 self.m[i][a1] = '*'
 elif b1 == b2:
 for i in range(min(a1,a2), max(a1, a2) + 1):
 self.m[b1][i] = '*'
 else:
 #диагональ
 n=[]
 if abs(a2-a1) > abs(b2-b1): #вширь
 d=abs(a2-a1)-1
 l=abs(b2-b1)-1
 if l==0:
 l+=1
 x=d//l
 i=d%l
 for j in range(l): #заполнение
 n.append(x)
 for p in range(i): # раскидаем оставшиеся по элементам массива
 if not p % 2:
 n[p % len(n)] += 1
 else:
 n[-(p % len(n))] += 1
 #нисходящая вправо
 if a2>a1 and b2>b1:
 a1+=1
 b1+=1
 for j in n:
 for _ in range(j):
 self.m[b1][a1]='*'
 a1+=1
 b1+=1
 #восходящая вправо
 elif a2>a1 and b2<b1:
 a1+=1
 b1-=1
 for j in n:
 for _ in range(j):
 self.m[b1][a1]='*'
 a1+=1
 b1-=1
 # восходящая влево
 elif a2<a1 and b2<b1:
 a1-=1
 b1-=1
 for j in n:
 for _ in range(j):
 self.m[b1][a1]='*'
 a1-=1
 b1-=1
 # нисходящая влево
 elif a2<a1 and b2>b1:
 a1-=1
 b1+=1
 for j in n:
 for _ in range(j):
 self.m[b1][a1]='*'
 a1-=1
 b1+=1
 else: #ввысоту
 d=abs(b2-b1)-1
 l=abs(a2-a1)-1
 if l==0:
 l+=1
 x=d//l
 i=d%l
 for j in range(l):
 n.append(x)
 for p in range(i): # раскидаем оставшиеся по элементам массива
 if not p % 2:
 n[p % len(n)] += 1
 else:
 n[-(p % len(n))] += 1
 # нисходящая влево ввысоту
 if a2<a1 and b2>b1:
 a1-=1
 b1+=1
 for j in n:
 for _ in range(j):
 self.m[b1][a1]='*'
 b1+=1
 a1-=1

 #нисходящая вправо ввысоту
 elif a2>a1 and b2>b1:
 a1+=1
 b1+=1
 for j in n:
 for _ in range(j):
 self.m[b1][a1]='*'
 b1+=1
 a1+=1
 #восходящая вправо ввысоту
 elif a2>a1 and b2<b1:
 a1+=1
 b1-=1
 for j in n:
 for _ in range(j):
 self.m[b1][a1]='*'
 b1-=1
 a1+=1
 # восходящая влево ввысоту
 elif a2<a1 and b2<b1:
 a1-=1
 b1-=1
 for j in n:
 for _ in range(j):
 self.m[b1][a1]='*'
 b1-=1
 a1-=1
 self.m[b1][a1]='*'
class Rect(Figure):
 def __init__(self, A, C, m):
 super().__init__(m)
 self.A = A
 self.C = C
 def coord(self):
 x1, x3, x2, x4 = self.A[0], self.C[0], self.C[0], self.A[0]
 y1, y3, y2, y4 = self.A[1], self.C[1], self.A[1], self.C[1]
 return x1, x2, x3, x4, y1, y2, y3, y4
 def area(self):
 x1, x2, x3, x4, y1, y2, y3, y4 = self.coord()
 return (x2 - x1) * (y3 - y2)
 def draw(self):
 x1, x2, x3, x4, y1, y2, y3, y4 = self.coord()
 for i in range(x1, x2 + 1):
 self.m[y1][i] = '*'
 self.m[y4][i] = '*'
 for j in range(y1 + 1, y4):
 self.m[j][x1] = '*'
 self.m[j][x2] = '*'
 return self.m
class Tri(Figure):
 def __init__(self, A, B, C, m):
 super().__init__(m)
 self.A = A
 self.B = B
 self.C = C
 def area(self):
 a = ((self.A[0] - self.B[0]) ** 2 + (self.A[1] - self.B[1]) ** 2) ** 0.5
 b = ((self.B[0] - self.C[0]) ** 2 + (self.B[1] - self.C[1]) ** 2) ** 0.5
 c = ((self.C[0] - self.A[0]) ** 2 + (self.C[1] - self.A[1]) ** 2) ** 0.5
 p = (a + b + c) / 2
 return (p * (p - a) * (p - b) * (p - c)) ** 0.5

 def combDrawing(self):
 for i in list(combinations([self.A, self.B, self.C], 2)):
 print(i)
 self.drawDia(i[0][0], i[0][1], i[1][0], i[1][1])
 return self.m
class Line(Figure):
 def __init__(self, A, B, m):
 super().__init__(m)
 self.A = A
 self.B = B
 def draw(self):
 if self.A[0]==self.B[0] or self.A[1]==self.B[1]:
 if self.A[0] == self.B[0]:
 for i in range(min(self.A[1],self.B[1]), max(self.A[1], self.B[1]) + 1):
 self.m[i][self.A[0]] = '*'
 elif self.A[1] == self.B[1]:
 for i in range(min(self.A[0],self.B[0]), max(self.A[0], self.B[0]) + 1):
 self.m[self.A[1]][i] = "*"
 else:
 self.drawDia(self.A[0], self.A[1], self.B[0], self.B[1])
 return self.m
pol = Rect((20, 44),(48, 49), [])
pol1 = Tri((20, 10), (30, 30),(4,25), [])
pol1.combDrawing()
pol1.printing()
pol1.area()
