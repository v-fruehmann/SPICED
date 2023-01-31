import numpy as np
import pandas as pd
import random
import time
import datetime
from datetime import datetime
import import_ipynb
from customer_class import Customer
from faker import Faker


STATES = ['entrance','dairy', 'drinks', 'fruit', 'spices', 'checkout']

probs = {
    'entrance':[0,0.25, 0.25, 0.25,0.10, 0.15],
    'dairy': [0, 0.391211, 0.000000, 0.223151, 0.189925, 0.195713],
    'drinks': [0,0.537023, 0.027159, 0.000000, 0.219062, 0.216756],
    'fruit': [0,0.499511, 0.238319, 0.136266, 0.000000, 0.125904],
    'spices': [0,0.251000, 0.323553, 0.273140, 0.152307, 0.000000],
    'checkout': [0,0.391211, 0.537023, 0.499511, 0.251000, 0.000000]
}


class Supermarket:
    """manages multiple Customer instances that are currently in the market.
    """

    def __init__(self):        
        self.customers = []
        self.minutes = 0
        self.last_id = 0
        self.current_time=0
        
    def __repr__(self):
        return f'Supermarket("{self.customers}", "{self.current_time}")'

    def get_time(self):
        """current time in HH:MM format
        """
        current_time = datetime.now()
        time = current_time.strftime("%H:%M")
        print(f'current_time: {time}')
        return time
    

    def print_customers(self):
        """print all customers with the current time and id in CSV format.
        """
        for customers in self.customers:
            time=self.get_time()
            name=customer.name
            current_location=customer.current_location
            
            fields=[time,name,state]
            with open('./spiced_working_files/customer.csv','a') as f:
                writer=csv.writer(f)
                writer.writerow(fields)
            return None

    def next_minute(self):
        """propagates all customers to the next state.
        """
        for customer in self.customers:
            customer.next_location()
            print(f"{customer.name} to {customer.current_location}")
        
        return None
    
    def add_new_customers(self):
        """randomly creates new customers.
        """
        for i in range(random.randint(1,5)):
            fake=Faker()
            name=fake.name()
            customer=Customer(name)
            self.customers.append(customer)
        return None

    def remove_exitsting_customers(self):
        """removes every customer that is not active any more.
        """
        self.is_active()
        for customer in self.customers:
            if cust.current_location=='checkout':
                self.customers.remove(cust)
                print(f'{cust} removed')
        



#rewe=Supermarket()
#print(repr(rewe))
#rewe.get_time()
#rewe.print_customers()
#rewe.customers
#rewe.add_new_customers()
#rewe.customers
#rewe.next_minute()




