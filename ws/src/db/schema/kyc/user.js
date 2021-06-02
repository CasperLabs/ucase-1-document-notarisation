import {default as mongoose} from 'mongoose';
import * as constants from './constants';


/**
 * dB schema for a user granted access to platform.
 */
export default new mongoose.Schema({
    name: {
        type: Object,
        required: true,
    },

    nationality: {
        type: String,
        required: true,
    },

    typeof: {
        type: String,
        required: true,
        enum: constants.USER_TYPE,
    },

    verificationStatus: {
        type: String,
        required: true,
        enum: constants.USER_VERIFICATION_STATE,
    },
}, {
    collection: 'kyc-user',
    timestamps: true
});
