const studentDetailReducer = (state = {}, action) => {

    switch (action.type) {
        case 'SET_STUDENT':
            console.log(action.payload);
            return action.payload;
        case 'UPDATE_STUDENT':
            console.log(state, action);
            return {
                ...state,
                [action.payload.key]: action.payload.value
            };
        default:
            return state;
    }    
}

export default studentDetailReducer;