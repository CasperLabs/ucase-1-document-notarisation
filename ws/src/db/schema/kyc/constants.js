/**
 * @fileOverview Database constants in context of users.
 */

// User types.
export const USER_TYPE_CLERK = 'legal-clerk';
export const USER_TYPE_LAWYER = 'lawyer';
export const USER_TYPE_PARTNER = 'partner';
export const USER_TYPE_ASSOCIATION = 'association';
export const USER_TYPE = [
    USER_TYPE_CLERK,
    USER_TYPE_LAWYER,
    USER_TYPE_PARTNER,
    USER_TYPE_ASSOCIATION,
];

// User onboarding verification state.
export const USER_VERIFICATION_STATE_VERIFIED = 'Verified';
export const USER_VERIFICATION_STATE_PENDING = 'Pending';
export const USER_VERIFICATION_STATE_REJECTED = 'Rejected';
export const USER_VERIFICATION_STATE = [
    USER_VERIFICATION_STATE_VERIFIED,
    USER_VERIFICATION_STATE_PENDING,
    USER_VERIFICATION_STATE_REJECTED,
];
