# car_rental

Flutter assessment for Nyntax.

# Bonus Question

Let's say you have a Tesla in your system that charges $10 per hour and $50 per day. What occurs now if the car is rented for six hours? Is the customer willing to pay more than the daily rate for one-fourth of the period? Regarding the hourly, daily, and weekly rate systems, how do you handle this issue? Describe your solution in the readme file of your project.

# Answer

After calculating the hour rate for 6(or any number) hours, I need to compare the amount with the daily rate. If the daily rate is lower than total hourly rate, i will choose the daily rate as my final amount. Same goes for daily and weekly rates too.