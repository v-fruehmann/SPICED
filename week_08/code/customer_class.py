import numpy as np
import pandas as pd
import random

# states of chain
STATES = ['entrance','dairy', 'drinks', 'fruit', 'spices', 'checkout']

# Transition matrix

#probs = trans_prob_matrix
probs = {
    'entrance':[0,0.25, 0.25, 0.25,0.10, 0.15],
    'dairy': [0, 0.391211, 0.000000, 0.223151, 0.189925, 0.195713],
    'drinks': [0,0.537023, 0.027159, 0.000000, 0.219062, 0.216756],
    'fruit': [0,0.499511, 0.238319, 0.136266, 0.000000, 0.125904],
    'spices': [0,0.251000, 0.323553, 0.273140, 0.152307, 0.000000],
    'checkout': [0,0.391211, 0.537023, 0.499511, 0.251000, 0.000000]
}


class Customer: 
    
    def __init__(self, name, probs=probs, current_location ='entrance'):
        self.name = name
        self.probs = probs
        self.current_location = current_location
        
        
    def is_active(self):
        return self.current_location != 'checkout' 
        
    def next_location(self):
        '''
        Customer class selects next location.
        
        '''
        self.current_location = random.choices(STATES, probs[self.current_location])[0]
        #print(f'I am at {self.current_location}')  
       
            
    def __repr__(self):
        return f"The customer {self.name} is at {self.current_location}"


cust1=Customer('Peter',probs)
#print(cust1.current_location)
cust1.next_location()
#print(cust1.current_location)


customers = customer_ids

def save_predicted_state(customers):
    for name in customers:
        new_customer = Customer(name)
        print(new_customer)
        new_customer.next_location()
        print(new_customer)
        states = new_customer.current_location
        
#save_predicted_state(customers)




