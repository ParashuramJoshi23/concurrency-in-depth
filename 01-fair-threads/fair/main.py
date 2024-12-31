import math
import time
from concurrent.futures import ProcessPoolExecutor, as_completed
from multiprocessing import Value

MAX_INT = 1000000
CONCURRENCY = 10
total_prime_numbers = Value('i', 0)
current_num = Value('i', 2)

def check_prime(x):
    if x % 2 == 0:
        return 0
    for i in range(3, int(math.sqrt(x)) + 1, 2):
        if x % i == 0:
            return 0
    return 1

def do_work(x):
    count = 0
    while True:
        if x > MAX_INT:
            break
        count += check_prime(x)
    return count

def main():
    start = time.time()

    with ProcessPoolExecutor(max_workers=CONCURRENCY) as executor:
        futures = [executor.submit(do_work, x) for x in range(CONCURRENCY)]

        for future in as_completed(futures):
            print(f"Worker {futures.index(future)} completed, Took {time.time() - start:.2f} seconds")
            with total_prime_numbers.get_lock():
                total_prime_numbers.value += future.result()

    print(f"Checking till {MAX_INT}, found {total_prime_numbers.value} prime numbers. Took {time.time() - start:.2f} seconds")

if __name__ == "__main__":
    main()
