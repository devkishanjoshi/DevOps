d = {}
file1 = input()
file2 = input()
with open(file1) as f:
    for line in f:
        (key, val) = line.split("=")
        d[key] = val.rstrip() 
with open(file2, 'a') as cf: 
    cf.write('''apiVersion: v1
kind: Secret
metadata:
  name: user-service-secret
type: Opaque
data:
''')
        
for (key,val) in d.items() :
    with open("change_secret", 'a') as cf:
        cf.write("  ")
        cf.write(key)
        cf.write(": ")
        cf.write(val)
        cf.write("\n")
    
        
       
        

       
