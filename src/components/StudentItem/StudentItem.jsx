import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';

//styling
import { withStyles } from '@material-ui/core/styles';
// import Card from '@material-ui/core/Card';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';

const styles = {
    card: {
        minWidth: 400,
        paddingBottom: '20%',
        
    },
    bullet: {
        display: 'inline-block',
        margin: '0 2px',
        transform: 'scale(0.8)',
        
    },
    title: {
        fontSize: 14,
        
    },
    pos: {
        marginBottom: 12,
        
    },
    paper: {
        height: 100,
        
        width: 140,
        
        
    }
    
    
};

class StudentItem extends Component {

    getDetail = (event, student) => {
        this.props.dispatch({
            type: 'GET_STUDENT_DETAIL',
            payload: student
        })
        this.goDetail();
    }
    
    goDetail = (event, student) => {
        this.props.history.push(`/studentdetail/${this.props.student.id}`);
    }

    render() {
        return (
            <div>
                <Grid container spacing={24}>
                    <Grid item xs={12}>
                    <Paper>
                
                    <CardContent>
                <li>
                    {this.props.student.lastname}, {this.props.student.firstname}
                    <Button key={this.props.student.id} onClick={(event) => this.getDetail(event, this.props.student.id)}>view details</Button>
                </li>
                    </CardContent>
                    </Paper>
                    </Grid>
                </Grid>
            </div>
        )
    }
}

const putReduxStateOnProps = (reduxState) => {
    return {
        reduxState
    }
}

export default withStyles(styles)(withRouter(connect(putReduxStateOnProps)(StudentItem)));