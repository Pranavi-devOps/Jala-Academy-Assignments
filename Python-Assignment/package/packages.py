class emp():
    def __init__(self, name ,age,salary): #constructor
        self.name = name 
        self.age = age 
        self.salary = salary

    #method 
    def display(self):
        print(f"My name is : {self.name}")
        print(f"My age is {self.age}")
        print(f"My salary is {self.salary}")

class manager(emp):
    def __init__(self, name ,age,salary):
        super().__init__(name,age,salary)
    
    def display(self):
        print(f"My name is : {self.name}")
        print(f"My age is {self.age}")
        print(f"My salary is {self.salary}")