# Q1: E1 - Type Casting and Numeric Operations
try:
    integer_text = input("Integer: ")
    decimal_text = input("Decimal: ")
    integer_value = int(integer_text)
    float_value = float(decimal_text)

    print("Integer Value :", integer_value)
    print("Integer Type  :", type(integer_value).__name__)
    print("Float Value   :", float_value)
    print("Float Type    :", type(float_value).__name__)
    print("Rounded Value :", round(float_value))

    if integer_value != 0:
        print(f"{integer_value} / {int(float_value)} = {integer_value / int(float_value):.4f}" if int(float_value) != 0 else "Division skipped: divisor is zero.")
        if int(float_value) != 0:
            print(f"{integer_value} // {int(float_value)} = {integer_value // int(float_value)}")
            print(f"{integer_value} % {int(float_value)} = {integer_value % int(float_value)}")
    else:
        print("Division skipped: first value is zero.")
    print(f"{integer_value} ** 2 = {integer_value ** 2}")
except ValueError:
    print("Invalid input. Enter a whole number and a valid decimal number.")


# Q2: E2 - Caesar Cipher
message = input("\nMessage: ")
shift = int(input("Shift: "))
shift %= 26

def caesar_transform(text, shift_amount):
    result = ""
    for character in text:
        if "A" <= character <= "Z":
            result += chr((ord(character) - ord("A") + shift_amount) % 26 + ord("A"))
        elif "a" <= character <= "z":
            result += chr((ord(character) - ord("a") + shift_amount) % 26 + ord("a"))
        else:
            result += character
    return result

encrypted = caesar_transform(message, shift)
decrypted = caesar_transform(encrypted, -shift)
print("Encrypted:", encrypted)
print("Decrypted:", decrypted)


# Q3: Number Analyzer
start = int(input("\nStart: "))
end = int(input("End: "))

print(f"{'Number':<8}{'Prime':<8}{'Perfect':<9}{'Armstrong':<12}{'Palindrome':<12}{'Digit Sum':<11}{'Digits':<8}{'Binary'}")
for number in range(start, end + 1):
    # Prime check
    is_prime = number >= 2
    for divisor in range(2, int(number ** 0.5) + 1):
        if number % divisor == 0:
            is_prime = False
            break

    # Digit operations
    digits = [int(digit) for digit in str(abs(number))]
    digit_sum = sum(digits)
    digit_count = len(digits)
    reversed_number = int("".join(str(digit) for digit in digits[::-1])) if digits else 0
    is_palindrome = number >= 0 and number == reversed_number

    # Perfect number check
    divisor_sum = 0
    if number > 1:
        for divisor in range(1, number):
            if number % divisor == 0:
                divisor_sum += divisor
    is_perfect = number > 0 and divisor_sum == number

    # Armstrong number check
    is_armstrong = number >= 0 and number == sum(digit ** digit_count for digit in digits)

    binary = format(number, "b") if number >= 0 else "-" + format(abs(number), "b")
    print(f"{number:<8}{('Yes' if is_prime else 'No'):<8}{('Yes' if is_perfect else 'No'):<9}{('Yes' if is_armstrong else 'No'):<12}{('Yes' if is_palindrome else 'No'):<12}{digit_sum:<11}{digit_count:<8}{binary}")


# Q4: E3 - Number System Converter and GCD/LCM
number1 = int(input("\nNumber 1: "))
number2 = int(input("Number 2: "))

if number1 <= 0 or number2 <= 0:
    print("Please enter two positive integers.")
else:
    def convert_base(number, base, digits):
        if number == 0:
            return "0"
        result = ""
        while number > 0:
            remainder = number % base
            result = digits[remainder] + result
            number //= base
        return result

    digits_for_hex = "0123456789ABCDEF"
    print("Binary      :", convert_base(number1, 2, digits_for_hex))
    print("Octal       :", convert_base(number1, 8, digits_for_hex))
    print("Hexadecimal :", convert_base(number1, 16, digits_for_hex))

    a, b = number1, number2
    while b != 0:
        a, b = b, a % b
    gcd = a
    lcm = (number1 * number2) // gcd
    print("GCD         :", gcd)
    print("LCM         :", lcm)


# Q5: Two-Divisor FizzBuzz
n = int(input("\nN: "))
divisor1 = int(input("Divisor 1: "))
word1 = input("Word 1: ")
divisor2 = int(input("Divisor 2: "))
word2 = input("Word 2: ")

if divisor1 == 0 or divisor2 == 0:
    print("Divisors cannot be zero.")
else:
    for number in range(1, n + 1):
        if number % divisor1 == 0 and number % divisor2 == 0:
            print(word1 + word2)
        elif number % divisor1 == 0:
            print(word1)
        elif number % divisor2 == 0:
            print(word2)
        else:
            print(number)


# Q6: Student Mark Conversion and Result Analyzer
student_count = int(input("\nStudents: "))
print(f"{'Student':<12}{'Total':<8}{'Average':<10}{'Grade'}")

for _ in range(student_count):
    student_name = input("Student name: ")
    mark_text = input(f"{student_name}'s marks (space-separated): ").split()

    try:
        marks = [float(mark) for mark in mark_text]
        if not marks or any(mark < 0 or mark > 100 for mark in marks):
            print(f"{student_name:<12}Invalid marks")
            continue

        total = sum(marks)
        average = total / len(marks)
        if average >= 90:
            grade = "A+"
        elif average >= 80:
            grade = "A"
        elif average >= 70:
            grade = "B"
        elif average >= 60:
            grade = "C"
        elif average >= 50:
            grade = "D"
        else:
            grade = "F"

        print(f"{student_name:<12}{total:<8.0f}{average:<10.2f}{grade}")
    except ValueError:
        print(f"{student_name:<12}Invalid marks")


# Q7: Digital Payment Transaction Analyzer
transaction_count = int(input("\nTransactions: "))
successful = []
rejected_count = 0

for index in range(transaction_count):
    transaction_text = input(f"Transaction {index + 1}: ")
    try:
        amount = float(transaction_text)
        if amount < 0:
            rejected_count += 1
        else:
            successful.append(amount)
    except ValueError:
        rejected_count += 1

print("Successful Transactions :", len(successful))
print(f"Total Amount            : ₹{sum(successful):.2f}")
if successful:
    print(f"Highest Transaction     : ₹{max(successful):.2f}")
    print(f"Lowest Transaction      : ₹{min(successful):.2f}")
    print(f"Average Transaction     : ₹{sum(successful) / len(successful):.2f}")
else:
    print("Highest Transaction     : N/A")
    print("Lowest Transaction      : N/A")
    print("Average Transaction     : N/A")
print("Rejected Transactions   :", rejected_count)


# Q8: LeetCode #8 - String to Integer (atoi)
text = input("\nEnter an integer string: ")
index = 0
length = len(text)

while index < length and text[index].isspace():
    index += 1

sign = 1
if index < length and text[index] in "+-":
    if text[index] == "-":
        sign = -1
    index += 1

number = 0
digits_found = False
while index < length and text[index].isdigit():
    number = number * 10 + (ord(text[index]) - ord("0"))
    digits_found = True
    index += 1

print(sign * number if digits_found else 0)


# Q9: LeetCode #67 - Add Binary
binary_a = input("\na = ").strip()
binary_b = input("b = ").strip()

if (not binary_a or not binary_b or
        any(bit not in "01" for bit in binary_a + binary_b)):
    print("Invalid binary input.")
else:
    i = len(binary_a) - 1
    j = len(binary_b) - 1
    carry = 0
    result = ""

    while i >= 0 or j >= 0 or carry:
        bit_a = int(binary_a[i]) if i >= 0 else 0
        bit_b = int(binary_b[j]) if j >= 0 else 0
        total = bit_a + bit_b + carry
        result = str(total % 2) + result
        carry = total // 2
        i -= 1
        j -= 1

    print(result)


# Q10: LeetCode #202 - Happy Number
number = int(input("\nEnter a positive integer: "))

if number <= 0:
    print(False)
else:
    seen = set()
    current = number
    while current != 1 and current not in seen:
        seen.add(current)
        digit_square_sum = 0
        while current > 0:
            digit = current % 10
            digit_square_sum += digit * digit
            current //= 10
        current = digit_square_sum
    print(current == 1)
