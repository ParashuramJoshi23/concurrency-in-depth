import threading

lock = threading.Lock()
global count
count = 0

def increment():
    global count
    count += 1

def main():
    threads = [threading.Thread(target=increment) for _ in range(1000000)]
    for thread in threads:
        thread.start()
    print(f"Count {count}")

if __name__ == "__main__":
    main()
