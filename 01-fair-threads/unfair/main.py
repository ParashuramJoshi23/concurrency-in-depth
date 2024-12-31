import math
import time
from concurrent.futures import ProcessPoolExecutor

MAX_INT = 10000000
CONCURRENCY = 10
total_prime_numbers = 0

def check_prime(x):
    if x % 2 == 0:
        return 0
    for i in range(3, int(math.sqrt(x)) + 1, 2):
        if x % i == 0:
            return 0
    return 1

def do_batch(nstart, nend):
    start = time.time()
    count = 0
    for i in range(nstart, nend):
        count += check_prime(i)
    duration = time.time() - start
    return count, duration

def main():
    global total_prime_numbers
    start = time.time()

    batch_size = MAX_INT // CONCURRENCY
    futures = []

    with ProcessPoolExecutor(max_workers=CONCURRENCY) as executor:
        nstart = 3
        for i in range(CONCURRENCY):
            nend = nstart + batch_size if i < CONCURRENCY - 1 else MAX_INT
            futures.append(executor.submit(do_batch, nstart, nend))
            nstart = nend

    for future in futures:
        count, duration = future.result()
        total_prime_numbers += count
        print(f"Worker {futures.index(future)} completed, Took {time.time() - start:.2f} seconds")
        print(f"Batch completed in {duration:.2f} seconds")

    print(f"Checking till {MAX_INT}, found {total_prime_numbers + 1} prime numbers. Took {time.time() - start:.2f} seconds")

if __name__ == "__main__":
    main()
