/**
 * @fileOverview Database engine (instantiated per request).
 */

// Module imports.
import * as _ from 'lodash';
import { default as mongoose } from 'mongoose';
import * as constants from '../utils/constants';
import * as dao from './dao/index';
import * as dbSchema from './schema/index';
import * as logger from '../utils/logging';


// Map of dB connection types to db engines.
export const ENGINES = {
    'query': null,
    'mutation': null,
}

// Set of valid connection types.
const CONNECTION_TYPES = Object.keys(ENGINES);

/**
 * Initialises managed db connections.
 */
export const initialise = (connectionType) => {
    _.each(Object.keys(ENGINES), (connectionType) => {
        ENGINES[connectionType] = getEngine(connectionType);
    })
    if (connectionType) {
        return getEngine(connectionType);
    }
};

/**
 * Returns a db engine for interaction with dB.
 */
export const getEngine = (connectionType) => {
    // Set db connection.
    const connection = getConnection(connectionType);

    // Set db models.
    const models = getModels(connection);

    // Return map of data access operations.
    return Object.assign(...Object.entries(dao).map(([funcName, func]) => ({
        [funcName]: (arg1, arg2) => {
            // Delegate to wrapper function.
            return execDao(models, func, funcName, arg1, arg2);
        }})
    ));
}

/**
 * Returns a db connection wrapper.
 */
const getConnection = (connectionType) => {
    // Defensive programming.
    if (CONNECTION_TYPES.includes(connectionType) === false) {
        throw new Error(`Unknown dB connection type: ${connectionType}`);
    }

    // Set URL.
    const urlKey = getUrlKey(connectionType);
    const url = constants[urlKey];

    // Set db name.
    const dbName = _.last(url.split('/'));

    // Return connection.
    return mongoose.createConnection(url, {
        dbName: dbName,
        poolSize: 5,
        useCreateIndex: true,
        useFindAndModify: false,
        useNewUrlParser: true
    });
}

/**
 * Returns key of url used to connect to dB.
 */
const getUrlKey = (connectionType) => {
    const isQuery = connectionType.includes('query');
    if (isQuery === true) {
        return 'MONGODB_URL_READONLY';
    } else {
        return 'MONGODB_URL_READWRITE';
    }
}

/**
 * Returns a map of database model's to schema's.
 */
const getModels = (connection) => {
    const result = {};

    // Drop the Schema suffix applied to each model for purposes of upstream code brevity.
    Object.keys(dbSchema).forEach((i) => {
        const modelName = i.slice(0, -6);
        result[modelName] = connection.model(modelName, dbSchema[i]);
    });

    return result;
}

/**
 * Wraps a data access operation execution.
 */
const execDao = (models, func, funcName, arg1, arg2) => {
    logger.logDB(`executing dao :: ${funcName}`);
    return func(models, arg1, arg2);
}
