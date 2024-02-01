#Alisha Patel

# opening instruction file to read instructions line by line
convert = open('cpu_instructions.txt', 'r')
  
file = open('cpu_image.txt', 'r')
image = open('cpu_ image.txt', 'w')                              
image.write("v3.0 hex words addressed\n")                   
hexcodes = []                                                

for line in convert:                                        
    operation = line[0:3:]                                    
    dest = line[5:6:] 
    first = line[8:9:]
    second = line[10:12:]
    imm = line[10:12:]
    if imm[0] == 'X':
        second = line[11:12:]
   

    mcode = ""
    if operation == "ADD":
        mcode = "00" + mcode                   
    elif operation == "ADR":
        second = line[11:12:]
        mcode = "01" + mcode
    elif operation == "LDR":
        mcode = "10" + mcode
    elif operation == "ORR":
        mcode = "11" + mcode

    
    binary = format(int(second), '02b')
    mcode = mcode + binary 
    

    binary = format(int(first), '02b')
    mcode = mcode + binary 
    

    binary = format(int(dest), '02b')
    mcode = mcode + binary
    mcode = format(int(mcode, 2), 'x')     
    hexcodes += [mcode]                       

# creating a list of lists where each list element is a 16 code long list
if len(hexcodes) > 16:
    n = 16
    lines = [hexcodes[i * n:(i + 1) * n] for i in range((len(hexcodes) + n - 1) // n )]
    #print(str(lines))

count = 0
for line in lines:
    space = " ".join(line)
    if len(line) == 16:
        space += "\n"
    else:
        for x in range (len(line), 16):
            space += " 00"
        space+= "\n"
    if count == 0:
        code = "00: " + space
    else:
        code = str(hex(count).lstrip("0x").rstrip("L")) + "0: " + space
    #print(code)
    count += 1
    image.writelines(code)

while(count != 16):
    image.writelines(str(hex(count).lstrip("0x").rstrip("L")) + "0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00" + "\n")
    count+=1
    

# Closing filesimage.close()
file.close()
image.close()
