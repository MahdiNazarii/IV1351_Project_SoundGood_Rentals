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

package com.soundgood.controller;

import java.util.ArrayList;
import java.util.List;

import com.soundgood.integration.InstrumentDAO;
import com.soundgood.integration.InstrumentDBException;
import com.soundgood.integration.RentalDAO;
import com.soundgood.model.Instrument;
import com.soundgood.model.InstrumentDTO;
import com.soundgood.model.InstrumentException;
import com.soundgood.model.RejectedException;
import com.soundgood.model.Rental;
import com.soundgood.model.RentalDTO;

/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */
public class Controller {
    private final InstrumentDAO instrumentDb;
    private final RentalDAO rentalDb;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     * 
     * @throws BankDBException If unable to connect to the database.
     */
    public Controller() throws InstrumentDBException {
        instrumentDb = new InstrumentDAO();
        rentalDb = new RentalDAO();
    }


     /**
     * Lists all non rented instruments in the soundgoodDB
     * 
     * @return A list containing all available instruments, if the list is empty there are no
     * available instruments.
     * @throws InstrumentDBException If unable to retrieve accounts.
     *
     * forUpdate = true if view is gotten for update
     */
    private List<? extends InstrumentDTO> getAllAvailableInstruments(boolean forUpdate) throws InstrumentException {
        try {
            return instrumentDb.findAllAvailableInstruments(forUpdate);
        } catch (Exception e) {
            throw new InstrumentException("Unable to list available instruments.", e);
        }
    }

    public List<? extends InstrumentDTO> getAllAvailableInstruments() throws InstrumentException {
        return getAllAvailableInstruments(false);
    }

     /**
     * Lists all available instruments by the specified type.
     * 
     * @param instrumentType The specified type for the instrument.
     * @return A list with all available instruments as the given.
     * @throws InstrumentException If unable to retrieve the instrument.
     */
    public List<? extends InstrumentDTO> getAllAvailableInstrumentType(String instrumentType) throws InstrumentException {
        if (instrumentType == null) {
            return new ArrayList<>();
        }

        try {
            return instrumentDb.findAvailableInstrumentsOfType(instrumentType);
        } catch (Exception e) {
            throw new InstrumentException("Controller: Could not search for the specified instrument.", e);
        }
    }


    public List<? extends RentalDTO> getAllRentedInstruments() throws InstrumentException {
        try {
            return rentalDb.findAllRentedInstruments();
        } catch(Exception e){
            throw new InstrumentException("Unable to list all rented instruments.", e);
        }
    }


    public void rentInstrument(int studentId, int instrumentId) throws InstrumentException {
        // get all available instruments and set an exclusive lock to the tables rows which are involved
       List<? extends InstrumentDTO> availableInstruments = getAllAvailableInstruments(true);
       try {
           RentalDTO rental = new Rental(studentId, instrumentId, availableInstruments);
           rentalDb.createRental(rental.getStudentId(), rental.getInstrumentId());
       } catch (InstrumentDBException | RejectedException e) {
           throw new RuntimeException(e);
       }
    }
    

    public void terminateRental(int rentalId) throws RejectedException {
        try {
            rentalDb.updateRental(rentalId);
        } catch(Exception e){
            throw new RejectedException("Unable to terminate rental. ", e);
        }
    }
   
}
