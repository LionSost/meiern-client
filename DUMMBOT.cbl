       IDENTIFICATION DIVISION.
       PROGRAM-ID. DUMMBOT.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 CURRENT-GAME.
          05 LAST-PLAYER PIC X(20).
          05 ANNOUNCED-DICE.
            07 DICE-1 PIC 9.
            07 FILLER PIC X.
            07 DICE-2 PIC 9.
       01 CURRENT-TURN.
          05 COMMAND PIC X(32).
             88 ROUND-STARTING VALUE "ROUND STARTING".
             88 YOUR-TURN VALUE "YOUR TURN".
             88 ROLLED VALUE "ROLLED".
             88 ANNOUNCED VALUE "ANNOUNCED".
             88 ANNOUNCE VALUE "ANNOUNCE".
          05 TOKEN   PIC X(36).
          05 ROLLED-DICE.
            07 DICE-1 PIC 9.
            07 FILLER PIC X.
            07 DICE-2 PIC 9.
       01 ANNOUNCE-DICE.
            07 DICE-1 PIC 9.
            07 FILLER PIC X.
            07 DICE-2 PIC 9.
       01 RANGFOLGE OCCURS 21.
           05 RANGFOLGE-DICE.
              07 DICE-1 PIC 9.
              07 FILLER PIC X.
              07 DICE-2 PIC 9.
       01 ANNOUNCED-RANGFOLGE PIC 99.
       01 ROLLED-RANGFOLGE PIC 99.
       01 VAR PIC 99.
       01 RANDOM-TIME PIC 99.
       01 RANDOM-ZAHL PIC 99.
       LINKAGE SECTION.
       01 BOT-PARAMETERS.
        COPY DATA.

       PROCEDURE DIVISION USING BOT-PARAMETERS.
           DISPLAY "SERVER-MESSAGE: " SERVER-MESSAGE
           PERFORM PARSE-SERVER-MESSAGE
           INITIALIZE MESSAGE-TO-SERVER
           PERFORM RANGFOLGE-EINRICHTEN
           EVALUATE TRUE
           WHEN ROUND-STARTING
              PERFORM HANDLE-ROUND-STARTING
           WHEN YOUR-TURN
              PERFORM HANDLE-YOUR-TURN
           WHEN ROLLED
              PERFORM HANDLE-ROLLED
           WHEN ANNOUNCED 
              PERFORM HANDLE-ANNOUNCED
           WHEN OTHER
               CONTINUE
      *        DISPLAY "Unknown command: " SERVER-MESSAGE
           END-EVALUATE
          *> DISPLAY "MESSAGE-TO-SERVER: " MESSAGE-TO-SERVER
           GOBACK
          .



       HANDLE-YOUR-TURN SECTION.
           IF DICE-1 IN ANNOUNCED-DICE <> 6 
              AND DICE-2 IN ANNOUNCED-DICE <> 6 THEN
              STRING "ROLL;" DELIMITED BY SIZE
                    TOKEN  DELIMITED BY SIZE
              INTO MESSAGE-TO-SERVER
           ELSE
              STRING "SEE;" DELIMITED BY SIZE
                    TOKEN DELIMITED BY SIZE
              INTO MESSAGE-TO-SERVER        
           END-IF
                  *> Überprüfen ob eigener Dice größer als der angesagte
                    *> wenn kleiner Überlegen ob gelogen werden soll
                    *> wenn kleiner Überlegen ob das angesagte gelogen
                  *> 
          EXIT.  


       

       HANDLE-ROUND-STARTING SECTION.
          STRING "JOIN;" DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER

           MOVE "0,0" TO ANNOUNCED-DICE
          EXIT.

       PARSE-SERVER-MESSAGE SECTION.
           UNSTRING SERVER-MESSAGE
            DELIMITED BY ';'
            INTO COMMAND
                 TOKEN
           EXIT.

       HANDLE-ROLLED SECTION.
           UNSTRING SERVER-MESSAGE
           DELIMITED BY ';'
           INTO COMMAND
                ROLLED-DICE
                TOKEN
           PERFORM HANDLE-ANNOUNCE
           EXIT.

       HANDLE-ANNOUNCE SECTION.
           IF DICE-1 IN ANNOUNCED-DICE = 0
           THEN 
              MOVE ROLLED-DICE TO ANNOUNCE-DICE
           ELSE

           PERFORM VARYING VAR FROM 1 BY 1 UNTIL VAR > 21 
              IF DICE-1 IN ANNOUNCED-DICE = DICE-1 IN RANGFOLGE(VAR)
                 AND DICE-2 IN ANNOUNCED-DICE = DICE-2 IN RANGFOLGE(VAR)
                 THEN
                 COMPUTE ANNOUNCED-RANGFOLGE = VAR
               END-IF
              IF DICE-1 IN ROLLED-DICE = DICE-1 IN RANGFOLGE(VAR)
                 AND DICE-2 IN ROLLED-DICE = DICE-2 IN RANGFOLGE(VAR)
              THEN 
                 COMPUTE ROLLED-RANGFOLGE = VAR
              END-IF
           END-PERFORM           
           IF ANNOUNCED-RANGFOLGE < ROLLED-RANGFOLGE
           THEN
              MOVE ROLLED-DICE TO ANNOUNCE-DICE
           ELSE
               PERFORM GENERATE-RAND
               MOVE RANGFOLGE(RANDOM-ZAHL) TO ANNOUNCE-DICE
           END-IF
           END-IF   

           DISPLAY ANNOUNCE-DICE" "ROLLED-DICE
           STRING "ANNOUNCE;" DELIMITED BY SIZE
              ANNOUNCE-DICE DELIMITED BY SIZE
              TOKEN DELIMITED BY SIZE
           INTO MESSAGE-TO-SERVER
           EXIT.
       

       GENERATE-RAND SECTION.
           MOVE FUNCTION CURRENT-DATE(15:2) TO RANDOM-TIME

           COMPUTE RANDOM-ZAHL = ANNOUNCED-RANGFOLGE + 1 +
              FUNCTION MOD(RANDOM-TIME, 20 - ANNOUNCED-RANGFOLGE)
       EXIT.

       HANDLE-ANNOUNCED SECTION.
           UNSTRING SERVER-MESSAGE
              DELIMITED BY ";"
              INTO LAST-PLAYER
                   ANNOUNCED-DICE
       EXIT.


       RANGFOLGE-EINRICHTEN SECTION.
           MOVE "3,1" TO RANGFOLGE(1) 
           MOVE "3,2" TO RANGFOLGE(2) 
           MOVE "4,1" TO RANGFOLGE(3) 
           MOVE "4,2" TO RANGFOLGE(4)      
           MOVE "4,3" TO RANGFOLGE(5) 
           MOVE "5,1" TO RANGFOLGE(6) 
           MOVE "5,2" TO RANGFOLGE(7) 
           MOVE "5,3" TO RANGFOLGE(8) 
           MOVE "5,4" TO RANGFOLGE(9) 
           MOVE "6,1" TO RANGFOLGE(10)
           MOVE "6,2" TO RANGFOLGE(11)
           MOVE "6,3" TO RANGFOLGE(12)
           MOVE "6,4" TO RANGFOLGE(13)
           MOVE "6,5" TO RANGFOLGE(14)
           MOVE "1,1" TO RANGFOLGE(15)
           MOVE "2,2" TO RANGFOLGE(16)
           MOVE "3,3" TO RANGFOLGE(17)
           MOVE "4,4" TO RANGFOLGE(18)
           MOVE "5,5" TO RANGFOLGE(19)
           MOVE "6,6" TO RANGFOLGE(20)
           MOVE "2,1" TO RANGFOLGE(21)
       EXIT.


       END PROGRAM DUMMBOT.
