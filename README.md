# IV1351_Project_Soundgood_Rentals

## Setting Up the Soundgood Database:

1. Navigate to the `resources` directory by following the path: `soundgood_rentals/src/main/resources`.
2. Execute the SQL code in the `CreateSoundGoodDB.sql` file.
3. Execute the SQL code in the `InsertDataToSoundGoodDB.sql` file.





## How to execute

1. Clone the directory
2. Open a terminal in the cloned directory and move one step inside the directory by `cd soundgood_rentals`.
3. Update the connection parameters in the `connectToSoundgoodDB` methods in the `InstrumentDAO.java` (row 80-85) and `RentalDAO.java`(row 55-59) files located in the `integration` directory.
   These files can be found at the following path: `soundgood_rentals/src/main/java/com/soundgood/integration`.
4. Build the project with the command `mvn install`
5. Run the program with the command `mvn exec:java`


## Commands for the Soundgood Rentals Program

- **`help`**: Displays all commands.
- **`available_instruments`**: Displays a list of all available instruments. Each instrument is shown with its `brand`, `type`, `price` and `instrument id`.
- **`available_instruments <instrument_type>`**: Displays all available instruments of the specified type, showing `brand`, `type`, `price` and `instrument id`.
- **`rented_instruments`**: Displays a list of all rented instruments. Each instrument is defined by its `type`, `price`, `instrument id`, `student id` and `rental id`.
- **`rent_instrument <student id, instrument id>`**: Adds a new row to the rented instruments list if the instrument is available and the student has not rented two instruments already.
- **`terminate_rental <rental id>`**: Removes the specified rental and updates the available instruments list.
- **`quit`**: Quits the program.

