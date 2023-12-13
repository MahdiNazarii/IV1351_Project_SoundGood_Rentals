/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.soundgood.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.soundgood.model.Instrument;

/**
 * This data access object (DAO) encapsulates all database calls in the bank
 * application. No code outside this class shall have any knowledge about the
 * database.
 */
public class InstrumentDAO {
  
    private static final String INSTRUMENT_FK = "instrument_id";
    private static final String INSTRUMENT_TYPE_NAME = "name";
    private static final String INSTRUMENT_BRAND = "brand";
    private static final String INSTRUMENT_PRICE = "price";
    private static final String INSTRUMENT_TABLE_NAME = "instruments";
    private static final String INSTRUMENT_TYPE_TABLE_NAME = "instrument_type";
    private static final String INSTRUMENT_DETAILS_TABLE_NAME = "instrument_details";
    private static final String RENTED_INSTRUMENT_TABLE_NAME = "rented_instrument";
    private static final String RENTAL_END_TIME = "rental_end_time";
    private static final String LOWER = "LOWER";
    private static final String NOW = "NOW()";
    private static final String INSTRUMENT_TYPE_FK = "instrument_type_id";
    private static final String INSTRUMENT_DETAILS_FK = "instrument_details_id";
  

    private Connection connection;
    private PreparedStatement findAvailableInstrumentOfTypeStmt;
    private PreparedStatement findAllAvailableInstrumentsStmt;
    private PreparedStatement findAllAvailableInstrumentsForUpdateStmt;
  

    /**
     * Constructs a new DAO object connected to the soundgood database.
     */
    public InstrumentDAO() throws InstrumentDBException {
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
     * Commits the current transaction.
     * 
     * @throws InstrumentDBException If unable to commit the current transaction.
     */
    public void commit() throws InstrumentDBException {
        try {
            connection.commit();
        } catch (SQLException e) {
            handleException("Failed to commit", e);
        }
    }

    /**
     * Searches for all instruments of the given type
     *
     * @param instrumentType The instrument type
     * @return A list with all instruments as the given type
     * @throws InstrumentDBException If failed to search for the instruments.
     */
    public List<Instrument> findAvailableInstrumentsOfType(String instrumentType) throws InstrumentDBException {
        String failureMsg = "Could not search for specified instrument.";
        ResultSet result = null;
        List<Instrument> instruments = new ArrayList<>();
        try {
            findAvailableInstrumentOfTypeStmt.setString(1, instrumentType);
            result = findAvailableInstrumentOfTypeStmt.executeQuery();
            while (result.next()) {
                instruments.add(new Instrument(result.getString(INSTRUMENT_BRAND),
                        result.getString(INSTRUMENT_TYPE_NAME),
                        result.getInt(INSTRUMENT_PRICE),
                        result.getInt(INSTRUMENT_FK)));
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return instruments;
    }

    /**
     * Retrieves all available instruments with different types.
     *
     * @return A list with all available instruments
     * @throws InstrumentDBException If failed to search for instruments.
     */
    public List<Instrument> findAllAvailableInstruments(boolean forUpdate) throws InstrumentDBException {
        String failureMsg = "Could not list instruments.";
        List<Instrument> instruments = new ArrayList<>();
        if(forUpdate){
            try (ResultSet result = findAllAvailableInstrumentsForUpdateStmt.executeQuery()) {
                while (result.next()) {
                    instruments.add(new Instrument(result.getString(INSTRUMENT_BRAND),
                            result.getString(INSTRUMENT_TYPE_NAME),
                            result.getInt(INSTRUMENT_PRICE),
                            result.getInt(INSTRUMENT_FK)));
                }
            } catch (SQLException sqle) {
                handleException(failureMsg, sqle);
            }
        } else {
            try (ResultSet result = findAllAvailableInstrumentsStmt.executeQuery()) {
                while (result.next()) {
                    instruments.add(new Instrument(result.getString(INSTRUMENT_BRAND),
                            result.getString(INSTRUMENT_TYPE_NAME),
                            result.getInt(INSTRUMENT_PRICE),
                            result.getInt(INSTRUMENT_FK)));
                }
                connection.commit();
            } catch (SQLException sqle) {
                handleException(failureMsg, sqle);
            }
        }
        return instruments;
    }

   


    private void prepareStatements() throws SQLException {
        findAvailableInstrumentOfTypeStmt = connection.prepareStatement("SELECT t1."
            + INSTRUMENT_FK + ", it." + INSTRUMENT_TYPE_NAME + ", ids." + INSTRUMENT_BRAND + ", ids." + INSTRUMENT_PRICE
            + " FROM " + INSTRUMENT_TABLE_NAME + " t1"
            + " LEFT JOIN " + INSTRUMENT_TYPE_TABLE_NAME + " it ON t1." + INSTRUMENT_TYPE_FK + " = it." + INSTRUMENT_TYPE_FK
            + " LEFT JOIN " + INSTRUMENT_DETAILS_TABLE_NAME + " ids ON t1." + INSTRUMENT_DETAILS_FK + " = ids." + INSTRUMENT_DETAILS_FK
            + " LEFT JOIN " + RENTED_INSTRUMENT_TABLE_NAME + " ri ON t1." + INSTRUMENT_FK + " = ri." + INSTRUMENT_FK
            + " AND ri." + RENTAL_END_TIME + " IS NULL"
            + " WHERE ri." + INSTRUMENT_FK + " IS NULL AND " + LOWER + "(it." + INSTRUMENT_TYPE_NAME + ") = " + LOWER + "(?)");

        findAllAvailableInstrumentsStmt = connection.prepareStatement("SELECT t1."
                + INSTRUMENT_FK + ", it." + INSTRUMENT_TYPE_NAME + ", ids." + INSTRUMENT_BRAND + ", ids." + INSTRUMENT_PRICE
                + " FROM " + INSTRUMENT_TABLE_NAME + " t1"
                + " LEFT JOIN " + INSTRUMENT_TYPE_TABLE_NAME + " it ON t1." + INSTRUMENT_TYPE_FK + " = it." + INSTRUMENT_TYPE_FK
                + " LEFT JOIN " + INSTRUMENT_DETAILS_TABLE_NAME + " ids ON t1." + INSTRUMENT_DETAILS_FK + " = ids." + INSTRUMENT_DETAILS_FK
                + " LEFT JOIN " + RENTED_INSTRUMENT_TABLE_NAME + " ri ON t1." + INSTRUMENT_FK + " = ri." + INSTRUMENT_FK
                + " AND ri." + RENTAL_END_TIME + " IS NULL"
                + " WHERE ri." + INSTRUMENT_FK + " IS NULL");

        findAllAvailableInstrumentsForUpdateStmt = connection.prepareStatement("WITH cte AS ("
                + " SELECT t1." + INSTRUMENT_FK + ", it." + INSTRUMENT_TYPE_NAME + ", ids." + INSTRUMENT_BRAND + ", ids." + INSTRUMENT_PRICE
                + " FROM " + INSTRUMENT_TABLE_NAME + " t1"
                + " LEFT JOIN " + INSTRUMENT_TYPE_TABLE_NAME + " it ON t1." + INSTRUMENT_TYPE_FK + " = it." + INSTRUMENT_TYPE_FK
                + " LEFT JOIN " + INSTRUMENT_DETAILS_TABLE_NAME + " ids ON t1." + INSTRUMENT_DETAILS_FK + " = ids." + INSTRUMENT_DETAILS_FK
                + " LEFT JOIN " + RENTED_INSTRUMENT_TABLE_NAME + " ri ON t1." + INSTRUMENT_FK + " = ri." + INSTRUMENT_FK
                + " AND ri." + RENTAL_END_TIME + " IS NULL"
                + " WHERE ri." + INSTRUMENT_FK + " IS NULL"
                + ")"
                + " SELECT * FROM cte"
                + " FOR UPDATE");
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

    private void closeResultSet(String failureMsg, ResultSet result) throws InstrumentDBException {
        try {
            result.close();
        } catch (Exception e) {
            throw new InstrumentDBException(failureMsg + " Could not close result set.", e);
        }
    }  
}
