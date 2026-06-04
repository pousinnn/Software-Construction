// Activity 5.2 Parallel and concurrent programming
// .C example without parallelism
// Paulina Cortez | A01782041
// June 03, 2026

//Excercise 1: Factorial
#include <stdio.h>
#include <stdlib.h>
#include <math.h> //(4)

unsigned long long factorial(int n); //For ex.1

int check_div(int x, int i, int limit); //for ex.2
int is_prime(int x);
long long prime_sum(int n);

double compute_pi(long n);

int main(int argc, char *argv[])
{
    int n = 5;
    if (argc > 1) {
        n = atoi(argv[1]);
    }
    printf("Exercise 1\n");
    printf("%llu is the factorial of %d\n", factorial(n), n);

    printf("\nExercise 2\n");
    printf("Prime sum up to %d = %lld\n", n, prime_sum(n));

    printf("\nExercise 3\n");
    printf("Pi up to %d rectangles = %.15f\n", 1000000, compute_pi(1000000));
    return 0;
}

unsigned long long factorial(int n)
{
    unsigned long long result = 1;
    for (int i=1; i <= n; i++) {
        result *= i;
    }
    return result;
}

//Excercise 2: 
int check_div(int x, int i, int limit)
{
    if (i > limit) {
        return 1;
    }
    if (x % i==0) {
        return 0;
    }
    return check_div(x, i + 2, limit);
}

int is_prime(int x)
{
    if (x < 2) {
        return 0;
    }
    if (x == 2) {
        return 1;
    }
    if (x % 2 == 0) {
        return 0;
    }
    int limit = (int) sqrt(x);
    return check_div(x, 3, limit);
}

long long prime_sum(int n)
{
    long long sum = 0;
    for (int i = 2; i <= n; i++) {
        if (is_prime(i)) {
            sum += i;
        }
    }
    return sum;
}

//Excercise 3
double compute_pi(long n)
{
    double width = 1.0/n;
    double sum = 0.0;
    for (long i = 0; i < n; i++) {
        double half = (i + 0.5) * width;
        double height = 4.0/(1.0 + half * half);
        sum += height;
    }
    return width * sum;
}