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
          05 TOKEN   PIC X(36).
          05 ROLLED-DICE.
            07 DICE-1 PIC 9.
            07 FILLER PIC X.
            07 DICE-2 PIC 9.
       LINKAGE SECTION.
       01 BOT-PARAMETERS.
        COPY DATA.

       PROCEDURE DIVISION USING BOT-PARAMETERS.
           DISPLAY "SERVER-MESSAGE: " SERVER-MESSAGE
           PERFORM PARSE-SERVER-MESSAGE
           INITIALIZE MESSAGE-TO-SERVER
           EVALUATE TRUE
           WHEN ROUND-STARTING
              PERFORM HANDLE-ROUND-STARTING
           WHEN YOUR-TURN
              PERFORM HANDLE-YOUR-TURN
           WHEN OTHER
               CONTINUE
      *        DISPLAY "Unknown command: " SERVER-MESSAGE
           END-EVALUATE
           DISPLAY "MESSAGE-TO-SERVER: " MESSAGE-TO-SERVER
           GOBACK
          .
       HANDLE-YOUR-TURN SECTION.
          STRING "SEE;" DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ROUND-STARTING SECTION.
          STRING "JOIN;" DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       PARSE-SERVER-MESSAGE SECTION.
           UNSTRING SERVER-MESSAGE
            DELIMITED BY ';'
            INTO COMMAND
                 TOKEN
           EXIT.

       END PROGRAM DUMMBOT.
