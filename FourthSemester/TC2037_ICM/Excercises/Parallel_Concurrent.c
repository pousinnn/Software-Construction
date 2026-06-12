/*
 * Examples of a race condition using threads.
 * All threads try to modify a single shared variable
 * Using a mutex to avoid memory corruption.
 *
 * Paulina Cortez
 * 26/05/2026
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

int main(int argc, char * argv[])
{
    for (int i=0; i<argc; i++){
        printf("Arg %d: %s\n", i, argv[i]);
    }
    return 0;
}