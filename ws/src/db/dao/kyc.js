/**
 * @fileOverview KYC related data access operations.
 */

import { createOrUpdate } from './utils';

/**
 * Either adds or updates information related to a platform user.
 *
 * @param {mongoose.Model} User - User dB model.
 * @param {object} obj - User data.
 */
export const setUser = async ({ User }, obj) => {
    return await createOrUpdate(User, obj, {
        userID: obj.userID,
    });
}

/**
 * Returns an individual user matched by user identifier.
 *
 * @param {mongoose.Model} IndividualCustomer - Individual customer database model .
 * @param {string} userID - user identifier (i.e. a public key).
 */
export const getUser = async ({ User }, userID) => {
    return await User.findOne({ userID });
};
