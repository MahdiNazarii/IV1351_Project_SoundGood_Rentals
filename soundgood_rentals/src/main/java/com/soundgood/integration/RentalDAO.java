package com.soundgood.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.soundgood.model.Instrument;
import com.soundgood.model.Rental;
import com.soundgood.model.RentalDTO;

public class RentalDAO {

    private static final String INSTRUMENT_DETAILS = "instrument_details";
    private static final String INSTRUMENT_TYPE_NAME = "name";
    private static final String INSTRUMENT_TABLE_NAME = "instruments";
    private static final String INSTRUMENT_BRAND = "brand";
    private static final String INSTRUMENT_PRICE = "price";
    private static final String INSTRUMENT_DETAILS_TABLE_NAME = "instrument_details";
    private static final String INSTRUMENT_TYPE_TABLE_NAME = "instrument_type";
    private static final String INSTRUMENT_TYPE_FK = "instrument_type_id";
    private static final String INSTRUMENT_DETAILS_FK = "instrument_details_id";
    private static final String RENTED_INSTRUMENT_TABLE_NAME = "rented_instrument";
    private static final String INSTRUMENT_FK = "instrument_id";
    private static final String RENTAL_END_TIME = "rental_end_time";
    private static final String RENTAL_START_TIME = "rental_start_time";
    private static final String RENTED_INSTRUMENT_FK = "rented_instrument_id";
    private static final String STUDENT_FK = "student_id";
    private static final String RENTAL_FK = "rented_instrument_id";
    private static final String NOW = "NOW()";

    Connection connection;
    private PreparedStatement findAllRentedInstrumentsStmt;
    private PreparedStatement createNewRentalStmt;
    private PreparedStatement terminateRentalStmt;



    public RentalDAO() throws InstrumentDBException {
        try {
            connectToSoundgoodDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new InstrumentDBException("Could not connect to datasource.", exception);
        }
    }

    /*
    * Create a connection to the soundgood database
    * In this example no password was needed but you maybe need to insert the password if you have a password on your server
    */
    private void connectToSoundgoodDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgood",
        "postgres", "");
        connection.setAutoCommit(false);
    }


     /**
     * Searches for all instruments that are currently rented
     * @return a List with objects Instrument
     */
    public List<? extends RentalDTO> findAllRentedInstruments() throws InstrumentDBException {
        String failureMsg = "Could not list instruments.";
        List<Rental> instruments = new ArrayList<>();
        try (ResultSet result = findAllRentedInstrumentsStmt.executeQuery()) {
            while (result.next()) {
                instruments.add(new Rental(result.getInt(INSTRUMENT_FK),
                        result.getInt(INSTRUMENT_PRICE),
                        result.getString(INSTRUMENT_TYPE_NAME),
                        result.getInt(STUDENT_FK),
                        result.getInt(RENTAL_FK)));
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return instruments;
    }

     /**
     * Searches for all accounts whose holder has the specified name.
     * @param student_id The students id
     * @param instrument_id the instrument that is to be rented
     *
     * @throws SoundgoodDBException If failed to search for available instrument.
     */
    public void createRental(int student_id, int instrument_id) throws InstrumentDBException {
        String failureMsg = "Could not create rental.";
        try{
            createNewRentalStmt.setInt(1, student_id);
            createNewRentalStmt.setInt(2, instrument_id);
            
            // executeUpdate the rented_instrument table
            int updatedRows = createNewRentalStmt.executeUpdate();
            if(updatedRows == 0){
                handleException(failureMsg, null);
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } 
    }


     /**
     * Terminate a rental by passing the rental_Id as argument.
     *
     * @param rentalId The id of the rental
     * @throws InstrumentDBException If failed to terminate rental with rental_Id.
     */
    public void updateRental(int rentalId) {
        String failureMsg = "Could not delete rental. ";
        try{
            terminateRentalStmt.setInt(1, rentalId);

            // execute the sql query and update rented_instruments table
            int updatedRows = terminateRentalStmt.executeUpdate();
            if(updatedRows == 0){
                handleException(failureMsg, null);
            }
            connection.commit();
        } catch (SQLException | InstrumentDBException e) {
            throw new RuntimeException(e);
        }
    }


    private void prepareStatements() throws SQLException {
        findAllRentedInstrumentsStmt = connection.prepareStatement("SELECT i."
            + INSTRUMENT_FK + ", ids." + INSTRUMENT_PRICE + ", it." + INSTRUMENT_TYPE_NAME + ", ri." + STUDENT_FK
            + ", ri." + RENTED_INSTRUMENT_FK
            + " FROM " + INSTRUMENT_TABLE_NAME + " i INNER JOIN " + INSTRUMENT_TYPE_TABLE_NAME
            + " it ON i." + INSTRUMENT_TYPE_FK + "=it." + INSTRUMENT_TYPE_FK
            + " INNER JOIN " + INSTRUMENT_DETAILS_TABLE_NAME + " ids ON i." + INSTRUMENT_DETAILS_FK + "=ids." + INSTRUMENT_DETAILS_FK
            + " INNER JOIN " + RENTED_INSTRUMENT_TABLE_NAME + " ri ON i." + INSTRUMENT_FK + "=ri." + INSTRUMENT_FK
            + " WHERE " + RENTAL_END_TIME + " IS NULL");

        createNewRentalStmt = connection.prepareStatement(
            "INSERT INTO " + RENTED_INSTRUMENT_TABLE_NAME + "("
            + RENTAL_START_TIME + ", "
            + RENTAL_END_TIME + ", "
            + STUDENT_FK + ", "
            + INSTRUMENT_FK + ") VALUES (NOW(), NULL, ?, ?)");
        
        terminateRentalStmt = connection.prepareStatement(
            "UPDATE " + RENTED_INSTRUMENT_TABLE_NAME + " SET " + RENTAL_END_TIME + "=" + NOW
            + " WHERE " + RENTED_INSTRUMENT_FK + " = (?) AND RENTAL_END_TIME IS NULL" );
        
    }

    private void handleException(String failureMsg, Exception cause) throws InstrumentDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg +
                    ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new InstrumentDBException(failureMsg, cause);
        } else {
            throw new InstrumentDBException(failureMsg);
        }
    }
}
