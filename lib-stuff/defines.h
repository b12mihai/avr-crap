#define INT_TRIGGER_LOW		0
#define INT_TRIGGER_CHANGE	1
#define INT_TRIGGER_FALLING	2
#define INT_TRIGGER_RISING  3

#define MAXIM(x, y) (x) ^ (((x) ^ (y)) & -((x) < (y)))
#define MINIM(x, y) (y) ^ (((x) ^ (y)) & -((x) < (y))) 

