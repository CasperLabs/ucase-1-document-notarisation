/**
 * @fileOverview Data access operation utility functions.
 */

/**
 * Either inserts or update an entity being persisted.
 *
 * @param {mongoose.Model} model - dB model type.
 * @param {object} obj - Model instance data.
 * @param {object} updateQuery - Query to select model instance when updating.
 * @return {object} Db model instance.
 */
export const createOrUpdate = async (model, obj, updateQuery) => {
    try {
        return await model.create(obj);
    }
    catch (err) {
        // Mongo error code 11000 indicates duplicate key.
        if (err.code === 11000) {
            return await model.updateOne(updateQuery, obj);
        } else {
            throw err;
        }
    }
};
