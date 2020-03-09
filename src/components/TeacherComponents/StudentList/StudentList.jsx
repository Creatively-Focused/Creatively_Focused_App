import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom'
// import Nav from '../Nav/Nav';
// import Footer from '../Footer/Footer';
// import ProtectedRoute from '../ProtectedRoute/ProtectedRoute'

class StudentList extends Component {
    componentDidMount() {
        this.props.dispatch({ type: 'GET_STUDENT' });
    }

    detailsBtn = (student) => {
        console.log('view button clicked')
        console.log(student)
    }

    addStudent = () => {
        this.props.history.push(`/addstudent`);
    }

    deleteBtn = (student) => {
        this.props.dispatch({
            type: 'DELETE_STUDENT',
            payload: student
        });
        console.log(student)
        
    }

    render() {
        return (
            <div>
                <h1>STUDENT LIST</h1>
                <button onClick={this.addStudent}>Add Student</button>
                <ul>
                    {this.props.student.map((student) => {
                        return <li key={student.id}>{student.firstname} {student.lastname}
                            
                            <button onClick={() => this.detailsBtn(student.id)}>View Details</button>
                            <button onClick={() => this.deleteBtn(student.id)}>Remove</button>
                            
                        </li>
                    }
                    )}

                </ul>
            </div>
        )
    }
}
const mapStateToProps = (state) => ({
    student: state.student,
    user: state.user
});
export default withRouter(connect(mapStateToProps)(StudentList));