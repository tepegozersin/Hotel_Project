import pandas as pd

salaries = pd.read_csv("C:/Users/tepeg/Desktop/Hotel_Project/salaries.csv")
employees = pd.read_csv("C:/Users/tepeg/Desktop/Hotel_Project/employee.csv")
leaves = pd.read_csv("C:/Users/tepeg/Desktop/Hotel_Project/leaves.csv")
staffing = pd.read_csv("C:/Users/tepeg/Desktop/Hotel_Project/staffing_needs.csv")

for df, name in zip([employees, salaries, leaves, staffing],
                    ['Employees', 'Salaries', 'Leaves', 'Staffing Needs']):
    print(f"\n{name} Info:")
    print(df.info())
    print(df.isnull().sum())

print("\nDuplicate Rows Check:")
print(employees.duplicated().sum())
print(salaries.duplicated().sum())
print(leaves.duplicated().sum())
print(staffing.duplicated().sum())

# Example: Remove rows with null departments
employees = employees[employees['department'].notnull()]

# Example: Convert 'month' to datetime
salaries['month'] = pd.to_datetime(salaries['month'])

# Save the clean data
employees.to_csv('employees_clean.csv', index=False)

