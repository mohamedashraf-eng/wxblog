---
title: Writing Cache-Friendly Code
layout: page
---

Hello! It's Mohamed Ashraf, and today I'll show you the importance of writing cache-friendly code.

---

Table of contents:  
- [Introduction](#introduction)
  - [What is cache memory](#what-is-cache-memory)
  - [Types of cache memory](#types-of-cache-memory)
  - [Cache Locality](#cache-locality)
- [Cache-friendly code](#cache-friendly-code)

# Introduction  

## What is cache memory  

Cache memory is a chip-based computer component that makes retrieving data from the computer's memory more efficient. 
It acts as a temporary storage area that the computer's processor can retrieve data from easily. This temporary storage area, known as a cache, is more readily available to the processor than the computer's main memory source, typically some form of dynamic random access memory (DRAM).

> **_NOTE:_**  A cache -- pronounced CASH -- is hardware or software that is used to store something, usually.  

Cache memory is typically integrated directly into the CPU chip or placed on a separate chip that has a separate bus interconnect with the CPU. Therefore, it is more accessible to the processor, and able to increase efficiency, because it's physically close to the processor.  
What it sacrifices in size and price, it makes up for in speed. Cache memory operates between 10 to 100 times faster than RAM, requiring only a few nanoseconds to respond to a CPU request. 

> **_NOTE:_**  Cache memory is made of High-Speed SRAM.

## Types of cache memory  

Cache memory is fast and expensive. Traditionally, it is categorized as "levels" that describe its closeness and accessibility to the microprocessor.  

**There are three general cache levels:**
**L1 cache**, or primary cache, is extremely fast but relatively small, and is usually embedded in the processor chip as CPU cache.

**L2 cache**, or secondary cache, is often more capacious than L1. L2 cache may be embedded on the CPU, or it can be on a separate chip or coprocessor and have a high-speed alternative system bus connecting the cache and CPU. That way it doesn't get slowed by traffic on the main system bus.

**Level 3 (L3) cache** is specialized memory developed to improve the performance of L1 and L2. L1 or L2 can be significantly faster than L3, though L3 is usually double the speed of DRAM. With multicore processors, each core can have dedicated L1 and L2 cache, but they can share an L3 cache. If an L3 cache references an instruction, it is usually elevated to a higher level of cache.  

> **_NOTE:_**  Cache memory offering read buffering for the CPU.

<p align="center">
<a href="https://ibb.co/fGPFHjQ"><img src="https://i.ibb.co/WpY5fms/cache-memory-levels.png" alt="cache-memory-levels" border="0"></a>
</p> 

We're not going to go deep details of cache memories. But all we need to know is *cache locality concept*.

## Cache Locality  

The ability of cache memory to improve a computer's performance relies on the concept of locality of reference. Locality describes various situations that make a system more predictable. Cache memory takes advantage of these situations to create a pattern of memory access that it can rely upon.  

**Two key ones for cache are:**  

- **Temporal locality:** This is when the same resources are accessed repeatedly in a short amount of time.
- **Spatial locality:** This refers to accessing various data or resources that are near each other.  

So that will lead us to the concept of cache prefetching.
**Cache prefetching** is the way for the CPU to fetch the data before it is needed by recognizing patterns in memory. (ex. Arrays)  

<p align="center">
<a href="https://ibb.co/BGm6qn1"><img src="https://i.ibb.co/RN16zj5/Memory-Comparasion.png" alt="Memory-Comparasion" border="0"></a><br /><a target='_blank' href='https://freeonlinedice.com/'></a><br />
</p> 

# Cache-friendly code  

After we knew that cache memory is a head faster and can increase I/O performance we need to know about cache hits/misses for our code performance.  

A cache hit occurs when the requested data can be found in a cache, while a cache miss occurs when it cannot. Cache hits are served by reading data from the cache, which is faster than recomputing a result or reading from a slower data store; thus, the more requests that can be served from the cache, the faster the system performs.  

<p align="center">
<a href="https://imgbb.com/"><img src="https://i.ibb.co/c2GhqFH/cache-writing-policy.png" alt="cache-writing-policy" border="0"></a>
</p>

Now to make use of cache in our code developing techqnieus.  

We will take an example of *Matrix Multiplication* code.  

Preparing our teting code:

1. Needed headers:  

```c
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
```  

2. Needed macros:  

```c
#define MAX_MATRIX_DATA_ARR (2048u)
#define E_(D_, i, j, sz) D_[i * sz + j] 
```  
The `MAX_MATRIX_DATA_ARR` macro is used to define the array size of the matrix data.
The `E_(D_, i, j, sz)` is used to make easy syntax.  

3. Needed types:  

```c
typedef double matrix_real_t;
typedef unsigned long matrix_size_t;

typedef struct {
    matrix_real_t* data;
    matrix_size_t a;
    matrix_size_t b;
} Matrix_t;
```  

This will be the main matrix to be used demonstrate the testing.  

4. Needed functions:  

```c
void matrix_init_zeros(Matrix_t* m) {
    if (m) for (matrix_size_t i = 0; i < (m->a * m->b); ++i) m->data[i] = 0;
}

void matrix_init_rand(Matrix_t* m) {
    if (m) for (matrix_size_t i = 0; i < (m->a * m->b); ++i) m->data[i] = rand() % 100u;
}

Matrix_t* matrix_get_instance(matrix_size_t sz) {
    assert(sz <= MAX_MATRIX_DATA_ARR);

    Matrix_t* m = (Matrix_t*) malloc(sizeof(Matrix_t));
    assert(m);

    m->a = sz;
    m->b = sz;

    m->data = (matrix_real_t*) malloc(sizeof(matrix_real_t) * (m->a * m->b));
    assert(m->data);

    return m;
}
```  
  
Matrix related functions used for the matrix class.

```c  
void mmul_cf(const Matrix_t* a, const Matrix_t* b, Matrix_t* c) {
    assert(a); assert(b); assert(c);

    for (matrix_size_t i = 0; i < a->a; ++i) {
        for (matrix_size_t k = 0; k < a->a; ++k) {
            for (matrix_size_t j = 0; j < a->a; ++j) {
                E_(c->data, i, j, a->a) += 
                    E_(a->data, i, k, a->a) * E_(b->data, k, j, a->a);
            }
        }
    }
}
```  

```c  
void mmul_cu(const Matrix_t* a, const Matrix_t* b, Matrix_t* c) {
    assert(a); assert(b); assert(c);

    for (matrix_size_t i = 0; i < a->a; ++i) {
        for (matrix_size_t j = 0; j < a->a; ++j) {
            for (matrix_size_t k = 0; k < a->a; ++k) {
                E_(c->data, i, j, a->a) += 
                    E_(a->data, i, k, a->a) * E_(b->data, k, j, a->a);
            }
        }
    }
}
```  

The matrix multiplication functions is used to perform the actual multiplication the one denoted with `_cu` is for the cache unfriendly multiplication and the `_cf` is for the cache friendly mutliplication.  

```c  
void print_time_difference(const char* label, struct timespec start, 
                struct timespec end, int test_iterations) {
    long seconds = end.tv_sec - start.tv_sec;
    long nanoseconds = end.tv_nsec - start.tv_nsec;
    double elapsed = seconds + nanoseconds*1e-9;
    elapsed /= test_iterations;
    printf("%s: %.9f seconds\n", label, elapsed);
}
```  

Timing measurements function is just used as utiliy for timing bench-marking.  

```c
int main(void) {
    matrix_size_t test_size = 1024;
    Matrix_t* a = matrix_get_instance(test_size); matrix_init_rand(a);
    Matrix_t* b = matrix_get_instance(test_size); matrix_init_rand(b);
    Matrix_t* c = matrix_get_instance(test_size); matrix_init_zeros(c);
    assert(a); assert(b); assert(c);

    int test_iterations = 10;
    struct timespec start, end;
    {
        /* Timing the row-major (cache-friendly) multiplication */
        clock_gettime(CLOCK_MONOTONIC, &start);
        for (int z = 0; z < test_iterations; ++z) {
            mmul_cf(a, b, c);
        }
        clock_gettime(CLOCK_MONOTONIC, &end);
        print_time_difference("Cache-Friendly", start, end, test_iterations);
    }
    matrix_init_zeros(c);
    {
        /* Timing the column-major (cache-unfriendly) multiplication */
        clock_gettime(CLOCK_MONOTONIC, &start);
        for (int z = 0; z < test_iterations; ++z) {
            mmul_cu(a, b, c);
        }
        clock_gettime(CLOCK_MONOTONIC, &end);
        print_time_difference("Cache-Unfriendly", start, end, test_iterations);
    }
    free(a); free(b); free(c); 

    return 0;
}
```  

The main function is used to initalize and start the test.
The test consits mainly of two phasses first phase is to run iterations for both mutiplication techniques and measure the time taken for the iterations by taking the avreage.  

Results:  

```Shell
Cache-Friendly: 8.322685631 seconds
Cache-Unfriendly: 14.041852030 seconds
```  

So now lets discuss the differece of accessing the array blocks that made the different

The major difference between the two functions is the swap of the mid and inner loops so the arrangement become `ijk` for the cache-unfriendly function, and `ikj` for the cache-friendly function.  

That made the big differece of making use of the cache prefetching and cache-hits so the cpu predcits the next move easily hence will increase performance by alot for large matrix multiplication.  

`(c) 2024, MoWx-12-07`