/* 
 * File:   lab5_p1.c
 * Author: Klinez_Wurmj
 *
 * Created on November 2, 2023, 8:24 AM
 */

#include "ece212.h"
#include "stdbool.h"
#define BTN11 !PORTBbits.RB11
/*
 * 
 */
int main() {
    bool Direction = true;
    int dChange = 1;
    ece212_setup();
        while(1){
            if(BTN11 == 1){
                if(Direction == true){
                    Direction = false;
                } 
                else{
                    Direction = true;
                }
            }
            
            if(Direction==true){
                if(dChange == 1){
                    writeLEDs(0x1);
                    delayms(500);
                    dChange++;
                }
                else if(dChange == 2){
                    writeLEDs(0x2);
                    delayms(500);
                    dChange++;
                }
                else if(dChange == 3){
                    writeLEDs(0x4);
                    delayms(500);
                    dChange++;
                }
                else if(dChange == 4){
                    writeLEDs(0x8);
                    delayms(500);
                    dChange++;
                }
                else if(dChange == 5){
                    dChange = 1;
                }
                else if(dChange == 0){
                    dChange = 4;
                }
                
            }
            else if(Direction==false){
                if(dChange == 1){
                    writeLEDs(0x1);
                    delayms(500);
                    dChange--;
                }
                else if(dChange == 2){
                    writeLEDs(0x2);
                    delayms(500);
                    dChange--;
                }
                else if(dChange == 3){
                    writeLEDs(0x4);
                    delayms(500);
                    dChange--;
                }
                else if(dChange == 4){
                    writeLEDs(0x8);
                    delayms(500);
                    dChange--;
                }
                else if(dChange == 5){
                    dChange = 1;
                }
                else if(dChange == 0){
                    dChange = 4;
                }
            }
            else{
                writeLEDs(0x0);
            }
            
            
            
        }
    return (EXIT_SUCCESS);
}

