/* 
 * File:   Lab06.c
 * Author: klinez
 *
 * Created on November 9, 2023, 9:33 AM
 */

#include "ece212.h"


/*
 * 
 */
int main(int argc, char** argv) {

    int senseL;
    int senseR;
    
    
    ece212_lafbot_setup();
    while(1){
        
        senseL = analogRead(LEFT_SENSOR);
        senseR = analogRead(RIGHT_SENSOR);
        //left sensor is off track
        if(senseR>=0x0174){
          RBACK = 0;
          RFORWARD = 0x0AAA;
          LBACK = 0;
          LFORWARD = 0xAAAA;
        }    
        //right sensor is off track  
        else if(senseL>=0x0174){
          RBACK = 0;
          RFORWARD = 0xAAAA;
          LBACK = 0;
          LFORWARD = 0x0AAA;  
        }  
        //both sensors are on track
        else{
          RBACK = 0;
          RFORWARD = 0xFFFF;
          LBACK = 0;
          LFORWARD = 0xFFFF; 
        } 
    }
    
    return (EXIT_SUCCESS);
}

