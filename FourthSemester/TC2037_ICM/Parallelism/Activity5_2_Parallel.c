// Activity 5.2 Parallel and concurrent programming
// .C example with parallelism
// Paulina Cortez | A01782041
// June 03, 2026

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <math.h> //(4)

unsigned long long parallelFactorial(int n, int threads);
long long parallel_prime_sum(int n, int threads);
double parallel_compute_pi(int n, int threads);

void *factorial_w(void *arg);
void *prime_w(void *arg);
void *pi_w(void *arg);

int is_prime(int x);

typedef struct {
    int id;
    int start;
    int end;
    double width;
    unsigned long long *result_ll;
    double *result_double;
    pthread_mutex_t * mutex;
} data_t;

int main(int argc, char * argv[])
{
    int n = 5;
    int threads = 4;

    if (argc > 1) {
        n = atoi(argv[1]);
    }
    if (argc > 2) {
        threads = atoi(argv[2]);
    }

    printf("\nExercise 1\n"); printf("Factorial of %d = %llu\n", n, parallelFactorial(n, threads));
    printf("\nExercise 2\n"); printf("Prime sum up to %d = %lld\n", n, parallel_prime_sum(n, threads));
    printf("\nPi approximation using 1000000 rectangles = %.15f\n", parallel_compute_pi(1000000, threads));

    return 0;
}

//Excercise 1: Factorial
unsigned long long parallelFactorial(int n, int threads)
{
    data_t thread_data[threads];
    pthread_t tids[threads];
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

    int range = n/threads;
    unsigned long long result = 1;
    
    for (int i = 0; i < threads; i++) {
        thread_data[i].start = i * range + 1;
        if (i == threads - 1) {
            thread_data[i].end = n;
        } else {
            thread_data[i].end = (i + 1) * range;
        }
        thread_data[i].result_ll = &result;
        thread_data[i].mutex = &mutex;
        pthread_create(&tids[i], NULL, factorial_w, &thread_data[i]);
    }
    for (int i = 0; i < threads; i++) {
        pthread_join(tids[i], NULL);
    }
    return result;
}
void *factorial_w(void *arg)
{
    data_t *d = (data_t *)arg;

    unsigned long long partial = 1;

    for (int i = d->start; i <= d->end; i++) {
        partial *= i;
    }

    pthread_mutex_lock(d->mutex);
    *(d->result_ll) *= partial;
    pthread_mutex_unlock(d->mutex);

    return NULL;
}

//Excercise 2: Prime numbers
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

    int limit = (int)sqrt(x);

    for (int i = 3; i <= limit; i += 2) {
        if (x % i == 0) {
            return 0;
        }
    }

    return 1;
}

long long parallel_prime_sum(int n, int threads)
{
    data_t data[threads];
    pthread_t tids[threads];
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

    int range = n/threads;
    long long result = 0;

    for (int i = 0; i < threads; i++) {
        data[i].start = 2 + i * range;
        if (i == threads - 1) {
            data[i].end = n;
        } else {
            data[i].end = 2 + (i+1) * range - 1;
        }
        data[i].result_ll = &result;
        data[i].mutex = &mutex;
        pthread_create(&tids[i], NULL, prime_w, &data[i]);
    }
    for (int i = 0; i < threads; i++) {
        pthread_join(tids[i], NULL);
    }
    return result;
}

void *prime_w(void *arg)
{
    data_t *d = (data_t *)arg;
    long long local_sum= 0;
    for (int i = d->start; i <= d->end; i++) {
        if (is_prime(i)) {
            local_sum += i;
        }
    }
    pthread_mutex_lock(d->mutex);
    *(d->result_ll) += local_sum;
    pthread_mutex_unlock(d->mutex);

    return NULL;
}

//Excercise 3: Pi approx
double parallel_compute_pi(int n, int threads)
{
    data_t data[threads];
    pthread_t tids[threads];
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

    int range = n/threads;
    double width= 1.0/n;
    double result= 0.0;

    for (int i=0; i < threads; i++) {
        data[i].start = i * range;
        if (i == threads - 1) {
            data[i].end = n - 1;
        } else {
            data[i].end = (i + 1) * range - 1;
        }

        data[i].width = width;
        data[i].result_double = &result;
        data[i].mutex = &mutex;
        pthread_create(&tids[i], NULL, pi_w, &data[i]);
    }
    for (int i = 0; i < threads; i++) {
        pthread_join(tids[i], NULL);
    }
    return width*result;
}
void *pi_w(void *arg)
{
    data_t *d = (data_t *)arg;
    double local_sum = 0.0;
    for (int i = d->start; i <= d->end; i++) {
        double width = d->width;
        double half = (i + 0.5) * width;
        double height = 4.0/(1.0 + half * half);

        local_sum += height;
    }

    pthread_mutex_lock(d->mutex);
    *(d->result_double) += local_sum;
    pthread_mutex_unlock(d->mutex);

    return NULL;
}