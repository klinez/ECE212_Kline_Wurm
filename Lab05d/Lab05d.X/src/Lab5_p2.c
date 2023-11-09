/* 
 * File:   Lab5_p2.c
 * Author: klinez wurm
 *
 * Created on November 2, 2023, 11:14 AM
 */

#include "ece212.h"

int main(int argc, char** argv) {
    ece212_lafbot_setup();
        while(1){
            RBACK = 0;
            RFORWARD = 0x7FFF;
            LBACK = 0;
            LFORWARD = 0x7FFF;
            delayms(500);
            
            RBACK = 0;
            RFORWARD = 0;
            LBACK = 0;
            LFORWARD = 0;
            delayms(1000);
            
            RBACK = 0x7FFF;
            RFORWARD = 0;
            LBACK = 0x7FFF;
            LFORWARD = 0;
            delayms(500);
            
            RBACK = 0;
            RFORWARD = 0;
            LBACK = 0;
            LFORWARD = 0;
            delayms(1000);
        }
    return (EXIT_SUCCESS);
}

