# Q1: E1 - Prime, Factorial, Fibonacci, Digit Sum and Reverse
n = int(input("Enter N: "))
number = int(input("Enter a number: "))

# Print prime numbers up to N using loops
print("Primes:", end=" ")
for value in range(2, n + 1):
    is_prime = True
    for divisor in range(2, int(value ** 0.5) + 1):
        if value % divisor == 0:
            is_prime = False
            break
    if is_prime:
        print(value, end=" ")
print()

# Calculate factorial using a loop
factorial = 1
if n < 0:
    print("Factorial: Not defined for negative numbers")
else:
    for value in range(1, n + 1):
        factorial *= value
    print("Factorial:", factorial)

# Print first N Fibonacci numbers
first, second = 0, 1
fibonacci = []
for _ in range(max(0, n)):
    fibonacci.append(first)
    first, second = second, first + second
print("Fibonacci:", *fibonacci)

# Calculate digit sum and reverse using arithmetic
temp = abs(number)
digit_sum = 0
reverse = 0
while temp > 0:
    digit = temp % 10
    digit_sum += digit
    reverse = reverse * 10 + digit
    temp //= 10
if number < 0:
    reverse = -reverse
print("Digit Sum:", digit_sum)
print("Reverse:", reverse)


# Q2: E2 - Patterns and Multiplication Grid
n = int(input("\nEnter pattern size N: "))

print("Right Triangle")
for row in range(1, n + 1):
    for _ in range(row):
        print("*", end="")
    print()

print("\nPyramid")
for row in range(1, n + 1):
    for _ in range(n - row):
        print(" ", end="")
    for _ in range(2 * row - 1):
        print("*", end="")
    print()

print("\nNumber Triangle")
for row in range(1, n + 1):
    for number in range(1, row + 1):
        print(number, end="")
    print()

print("\nMultiplication Grid")
for row in range(1, 11):
    for column in range(1, 11):
        print(f"{row} x {column} = {row * column:<3}", end="  ")
    print()


# Q3: E3 - String Analyzer
text = input("\nEnter a string: ")

# Reverse the string using a loop
loop_reverse = ""
for character in text:
    loop_reverse = character + loop_reverse
print("Loop Reverse:", loop_reverse)
print("Slice Reverse:", text[::-1])

# Ignore case and spaces for palindrome checking
cleaned = ""
for character in text.lower():
    if character != " ":
        cleaned += character
print("Palindrome:", "Yes" if cleaned == cleaned[::-1] else "No")

vowels = "aeiou"
vowel_count = 0
consonant_count = 0
digit_count = 0
for character in text.lower():
    if character in vowels:
        vowel_count += 1
    elif character.isalpha():
        consonant_count += 1
    elif character.isdigit():
        digit_count += 1
print("Vowels:", vowel_count)
print("Consonants:", consonant_count)
print("Digits:", digit_count)


# Q4: Formatted Electricity Bill
customer = input("\nEnter customer name: ")
units = int(input("Enter units consumed: "))

if units < 0:
    print("Units cannot be negative.")
else:
    # The worksheet does not state the slab rates. These example-based rates
    # reproduce its sample amount of ₹950 for 250 units:
    # first 100 units at ₹2, next 100 at ₹4, units above 200 at ₹7.
    if units <= 100:
        amount = units * 2
    elif units <= 200:
        amount = 100 * 2 + (units - 100) * 4
    else:
        amount = 100 * 2 + 100 * 4 + (units - 200) * 7
    print(f"Customer : {customer}")
    print(f"Units    : {units}")
    print(f"Amount   : ₹{amount:.2f}")


# Q5: ATM Cash Withdrawal and Denomination Breakdown
amount = int(input("\nWithdrawal Amount: "))

if amount <= 0:
    print("Withdrawal amount must be positive.")
elif amount > 20000:
    print("Transaction rejected: withdrawal limit is ₹20,000.")
elif amount % 10 != 0:
    print("Transaction rejected: amount must be a multiple of ₹10.")
else:
    remaining = amount
    total_notes = 0
    for denomination in (500, 200, 100, 50, 10):
        notes = remaining // denomination
        remaining %= denomination
        total_notes += notes
        print(f"₹{denomination} notes : {notes}")
    print("Total Notes :", total_notes)
    print("Amount      : ₹", amount, sep="")


# Q6: Digital Parking Fee and Time Calculator
def time_to_minutes(time_text):
    parts = time_text.strip().split(":")
    if len(parts) != 2:
        raise ValueError("Time must be in HH:MM format.")
    hours, minutes = int(parts[0]), int(parts[1])
    if not (0 <= hours <= 23 and 0 <= minutes <= 59):
        raise ValueError("Enter a valid 24-hour time.")
    return hours * 60 + minutes

try:
    entry_time = input("\nEntry Time (HH:MM): ")
    exit_time = input("Exit Time (HH:MM): ")
    entry_minutes = time_to_minutes(entry_time)
    exit_minutes = time_to_minutes(exit_time)

    duration = exit_minutes - entry_minutes
    if duration < 0:
        duration += 24 * 60
    hours, minutes = divmod(duration, 60)
    billable_hours = (duration + 59) // 60

    if duration == 0:
        fee = 0
        billable_hours = 0
    elif billable_hours == 1:
        fee = 30
    else:
        fee = 30 + (billable_hours - 1) * 20

    print(f"Parking Duration : {hours} hours {minutes} minutes")
    print(f"Billable Hours   : {billable_hours}")
    print(f"Parking Fee      : ₹{fee}")
except ValueError as error:
    print("Invalid time:", error)


# Q7: Delivery Charge and Earnings Report
delivery_count = int(input("\nNumber of Deliveries: "))
if delivery_count <= 0:
    print("Number of deliveries must be positive.")
else:
    distances = []
    for index in range(delivery_count):
        distance = float(input(f"Distance for delivery {index + 1} (km): "))
        if distance < 0:
            print("Distance cannot be negative. Using 0 km for this delivery.")
            distance = 0
        distances.append(distance)

    total_distance = sum(distances)
    total_earnings = 0
    for distance in distances:
        if distance <= 5:
            total_earnings += 40
        else:
            total_earnings += 40 + (distance - 5) * 8

    average_distance = total_distance / delivery_count
    print(f"Total Distance   : {total_distance:.2f} km")
    print(f"Total Earnings   : ₹{total_earnings:.2f}")
    print(f"Average Distance : {average_distance:.2f} km")


# Q8: LeetCode #7 - Reverse Integer
x = int(input("\nEnter an integer to reverse: "))
sign = -1 if x < 0 else 1
temp = abs(x)
reversed_number = 0
while temp > 0:
    reversed_number = reversed_number * 10 + temp % 10
    temp //= 10
print(sign * reversed_number)


# Q9: LeetCode #9 - Palindrome Number
x = int(input("\nEnter an integer to check for palindrome: "))
if x < 0:
    print(False)
else:
    original = x
    temp = x
    reversed_number = 0
    while temp > 0:
        reversed_number = reversed_number * 10 + temp % 10
        temp //= 10
    print(original == reversed_number)


# Q10: LeetCode #412 - Fizz Buzz
n = int(input("\nEnter N for Fizz Buzz: "))
for number in range(1, n + 1):
    if number % 3 == 0 and number % 5 == 0:
        print("FizzBuzz")
    elif number % 3 == 0:
        print("Fizz")
    elif number % 5 == 0:
        print("Buzz")
    else:
        print(number)
