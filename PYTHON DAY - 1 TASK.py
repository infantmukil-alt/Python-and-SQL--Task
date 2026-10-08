# Q1: Temperature Conversion and Formatted Output
celsius = float(input("Enter temperature in Celsius: "))
fahrenheit = (celsius * 9 / 5) + 32
kelvin = celsius + 273.15

print(f"Celsius: {celsius:.2f}°C")
print(f"Fahrenheit: {fahrenheit:.2f}°F")
print(f"Kelvin: {kelvin:.2f} K")

print("\nConversion Table")
print(f"{'Celsius':>10} {'Fahrenheit':>12} {'Kelvin':>10}")
for c in range(-40, 101, 10):
    f = (c * 9 / 5) + 32
    k = c + 273.15
    print(f"{c:10.2f} {f:12.2f} {k:10.2f}")


# Q2: Three-Number Analyzer
a, b, c = map(float, input("\nEnter three numbers separated by spaces: ").split())
number = int(input("Enter a number for classification: "))

print(f"Largest: {max(a, b, c):g}")
print(f"Smallest: {min(a, b, c):g}")
print(f"Average: {(a + b + c) / 3:.2f}")

if number > 0:
    if number % 2 == 0:
        print("Classification: Positive and Even")
    else:
        print("Classification: Positive and Odd")
elif number < 0:
    if number % 2 == 0:
        print("Classification: Negative and Even")
    else:
        print("Classification: Negative and Odd")
else:
    print("Classification: Zero")


# Q3: Leap Year and Grade Calculator
year = int(input("\nYear: "))
marks = float(input("Marks: "))

if (year % 400 == 0) or (year % 4 == 0 and year % 100 != 0):
    print(f"{year} is a Leap Year")
else:
    print(f"{year} is not a Leap Year")

if marks < 0 or marks > 100:
    print("Invalid marks. Enter a value between 0 and 100.")
else:
    if marks >= 90:
        grade = "A+"
    elif marks >= 80:
        grade = "A"
    elif marks >= 70:
        grade = "B"
    elif marks >= 60:
        grade = "C"
    elif marks >= 50:
        grade = "D"
    else:
        grade = "F"
    print(f"Grade: {grade}")


# Q4: Placement Bill Calculator
items = []
while True:
    value = input("\nEnter item price or 'done': ").strip()
    if value.lower() == "done":
        break
    try:
        price = float(value)
        if price < 0:
            print("Price cannot be negative.")
        else:
            items.append(price)
    except ValueError:
        print("Enter a valid price.")

subtotal = sum(items)
if subtotal >= 1000:
    discount_rate = 0.10
elif subtotal >= 500:
    discount_rate = 0.05
else:
    discount_rate = 0.00

discount = subtotal * discount_rate
after_discount = subtotal - discount
tax_rate = 0.05
tax = after_discount * tax_rate
final_amount = after_discount + tax

print("\nItem         Price")
print("-----------------")
for i, price in enumerate(items, 1):
    print(f"Item {i:<5} {price:>8.2f}")
print("-----------------")
print(f"{'Subtotal':<14}{subtotal:>8.2f}")
print(f"{'Discount':<14}{discount:>8.2f}")
print(f"{'Tax':<14}{tax:>8.2f}")
print(f"{'Final':<14}{final_amount:>8.2f}")


# Q5: Swap Without a Temporary Variable
a = int(input("\nEnter a: "))
b = int(input("Enter b: "))
print(f"Before Swap: a = {a}, b = {b}")
a, b = b, a
print(f"After Swap: a = {a}, b = {b}")


# Q6: Simple Interest Report
principal = float(input("\nPrincipal: "))
rate = float(input("Rate: "))
time = float(input("Time: "))

if principal < 0 or time < 0:
    print("Principal and time must be non-negative.")
else:
    simple_interest = (principal * rate * time) / 100
    total_amount = principal + simple_interest
    print(f"Principal       : {principal:.2f}")
    print(f"Rate            : {rate:.2f}%")
    print(f"Time            : {time:.2f} years")
    print(f"Simple Interest : {simple_interest:.2f}")
    print(f"Total Amount    : {total_amount:.2f}")


# Q7: Type Inspector
value = input("\nEnter a value: ")
print("Original value type :", type(value).__name__)

try:
    integer_value = int(value)
    print("Integer value       :", integer_value)
    print("Integer type        :", type(integer_value).__name__)
except ValueError:
    print("Invalid integer conversion")

try:
    float_value = float(value)
    print("Float value         :", float_value)
    print("Float type          :", type(float_value).__name__)
except ValueError:
    print("Invalid float conversion")


# Q8: Fix the Bug - Input Types
a = float(input("\nEnter first value: "))
b = float(input("Enter second value: "))
total = a + b
print(f"Sum: {total:g}")


# Q9: Multiple Assignment Analyzer
a, b, c, d, e = 10, 3.14, "Python", True, None
values = (a, b, c, d, e)

for value in values:
    print(f"Value: {value} Type: {type(value).__name__}")


# Q10: Expression Evaluator
a = 19
b = 4
print(f"a / b = {a / b}")
print(f"a // b = {a // b}")
print(f"a % b = {a % b}")
print(f"a ** b = {a ** b}")
print(f"-19 // 4 = {-19 // 4}")
