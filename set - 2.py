# Q-1 – Write a Python program to input a sentence and a positive integer from the user. Perform the following tasks:
s = input("Enter a sentence: ")
num = input("Enter a positive integer: ")
w = s.split()

# 1.	Display all the words in the sentence which contain exactly 3 vowels.
print("\nWords containing exactly 3 vowels:")
for x in w:
    vc = 0
    for ch in x.lower():
        if ch in "aeiou":
            vc = vc + 1
    if vc == 3:
        print(x)
# 2.	Display the word(s) having the maximum number of distinct characters.
mx = 0
for x in w:
    dc = len(set(x.lower()))
    if dc > mx:
        mx = dc
print("\nMaximum distinct character count:", mx)
print("Words having maximum distinct characters:")
for x in w:
    dc = len(set(x.lower()))
    if dc == mx:
        print(x)
# 3.	Find the difference between the largest and smallest digit of the given number.
big = max(num)
small = min(num)
diff = int(big) - int(small)
print("\nDifference:", diff)
# 4.	Check whether the sum of the first and last digit of the number is equal to the sum of all the remaining digits.
fd = int(num[0])
ld = int(num[-1])
fl = fd + ld
rest = 0
for d in num[1:-1]:
    rest = rest + int(d)
print("First + Last:", fl)
print("Remaining digits sum:", rest)
if fl == rest:
    print("Result: Equal")
else:
    print("Result: Not Equal")

# Q-2 –Write a Python program to input n positive integers from the user and store them in a list. Perform the following tasks:
n = int(input("Enter number of integers: "))
nums = []
for i in range(n):
    x = input("Enter positive integer: ")
    nums.append(x)
# 1.	Create a dictionary where:
# o	Key → Number
# o	Value → Number of even digits present in it
ed = {}
for x in nums:
    ec = 0
    for d in x:
        if int(d) % 2 == 0:
            ec = ec + 1
    ed[int(x)] = ec
print("\nEven Digit Dictionary:")
print(ed)
# 2.	Create a tuple containing all numbers whose first digit is equal to the last digit.
sfl = []
for x in nums:
    if x[0] == x[-1]:
        sfl.append(int(x))
st = tuple(sfl)
print("\nNumbers with same first and last digit:")
print(st)
# 3.	Create a set containing all the even digits occurring in the given numbers.
evd = set()
for x in nums:
    for d in x:
        if int(d) % 2 == 0:
            evd.add(int(d))
print("\nSet of even digits:")
print(evd)
# 4.	Display the numbers whose digit sum is greater than the average digit sum of all the numbers.
ds = []
for x in nums:
    t = 0
    for d in x:
        t = t + int(d)
    ds.append(t)
avg = sum(ds) / len(ds)
print("\nAverage digit sum:", avg)
print("Numbers greater than average digit sum:")
for i in range(len(nums)):
    if ds[i] > avg:
        print(nums[i])
# 5.	Find and display the number(s) containing the maximum number of distinct digits.
mx = 0
for x in nums:
    dc = len(set(x))
    if dc > mx:
        mx = dc
print("\nMaximum distinct digit count:", mx)
print("Numbers with maximum distinct digits:")
for x in nums:
    dc = len(set(x))
    if dc == mx:
        print(x)

# Q-3 Write a Python program to accept details of n vehicles and create a dictionary in the following format:
veh = {
    101: ["Swift", "Car", 1800, "Available"],
    102: ["Activa", "Scooter", 700, "Rented"],
    103: ["Creta", "Car", 2500, "Available"],
    104: ["Bullet", "Bike", 1200, "Available"]
}
# Where:
# Key → Vehicle ID
# Value → [Vehicle Name, Vehicle Type, Rent per Day, Status]
# Perform the following tasks:
# 1.	Create a new dictionary where Vehicle ID is the key and value is a tuple containing:
# (Vehicle Name, Rent for 5 Days)
rd = {}
for vid in veh:
    det = veh[vid]
    name = det[0]
    rpd = det[2]
    r5 = rpd * 5
    rd[vid] = (name, r5)
print("Rent Dictionary:")
print(rd)
# 2.	Create a set containing all the different vehicle types.
vt = set()
for vid in veh:
    det = veh[vid]
    vt.add(det[1])
print("\nDifferent Vehicle Types:")
print(vt)
# 3.	Display all vehicles which are "Available" and have rent less than ₹2000 per day.
print("\nAvailable vehicles with rent less than 2000:")
for vid in veh:
    det = veh[vid]
    name = det[0]
    rpd = det[2]
    stat = det[3]
    if stat == "Available" and rpd < 2000:
        print(vid, name, rpd)
# 4.	Find and display the available vehicle having the highest rent per day.
hr = 0
hv = ""
for vid in veh:
    det = veh[vid]
    name = det[0]
    rpd = det[2]
    stat = det[3]
    if stat == "Available":
        if rpd > hr:
            hr = rpd
            hv = name
print("\nAvailable vehicle with highest rent:")
print(hv, hr)
# 5.	Count and display the number of vehicles that are "Available" and "Rented".
ac = 0
rc = 0
for vid in veh:
    det = veh[vid]
    stat = det[3]
    if stat == "Available":
        ac = ac + 1
    elif stat == "Rented":
        rc = rc + 1
print("\nAvailable vehicles:", ac)
print("Rented vehicles:", rc)
