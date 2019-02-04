       IDENTIFICATION DIVISION.
       PROGRAM-ID. SIMPLBOT.
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
          05 ROLL-COMPARE-FLAGS.
            07 MY-DICE-IS-HIGHER-KZ PIC X VALUE SPACE.
             88 MY-DICE-IS-HIGHER VALUE 'H'.
             88 MY-DICE-IS-EQUAL VALUE 'E'.
             88 MY-DICE-IS-LOWER VALUE 'L'.
            07 ANNOUNCED-KZ PIC X VALUE SPACE.
             88 PASCH-ANNOUNCED VALUE 'P'.
            07 ROLLED-KZ PIC X VALUE SPACE.
             88 PASCH-ROLLED VALUE 'P'.
             88 MAEXCHEN-ROLLED VALUE 'M'.
       LINKAGE SECTION.
       01 BOT-PARAMETERS.
        COPY DATA.

       PROCEDURE DIVISION USING BOT-PARAMETERS.
           PERFORM PARSE-SERVER-MESSAGE
           INITIALIZE MESSAGE-TO-SERVER
           EVALUATE TRUE
           WHEN ROUND-STARTING
              PERFORM HANDLE-ROUND-STARTING
           WHEN ANNOUNCED
              PERFORM HANDLE-ANNOUNCED
           WHEN YOUR-TURN
              PERFORM HANDLE-YOUR-TURN
           WHEN ROLLED
              PERFORM HANDLE-ROLLED
           WHEN OTHER
               CONTINUE
      *        DISPLAY "Unknown command: " SERVER-MESSAGE
           END-EVALUATE
           GOBACK
          .
       HANDLE-YOUR-TURN SECTION.
          STRING "ROLL;" DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ROLLED SECTION.
          PERFORM PARSE-SERVER-MESSAGE-ROLLED
          STRING "ANNOUNCE;" DELIMITED BY SIZE
                 ROLLED-DICE DELIMITED BY SIZE
                 ";"         DELIMITED BY SIZE
                  TOKEN      DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ROUND-STARTING SECTION.
          STRING "JOIN;" DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ANNOUNCED SECTION.
          UNSTRING SERVER-MESSAGE DELIMITED BY ';'
              INTO COMMAND
                   LAST-PLAYER
                   ANNOUNCED-DICE
          EXIT.

       PARSE-SERVER-MESSAGE SECTION.
           UNSTRING SERVER-MESSAGE
            DELIMITED BY ';'
            INTO COMMAND
                 TOKEN
           EXIT.

       PARSE-SERVER-MESSAGE-ROLLED SECTION.
           UNSTRING SERVER-MESSAGE
            DELIMITED BY ';'
            INTO COMMAND
                 ROLLED-DICE
                 TOKEN
           EXIT.

       COMPARE-ROLLED-DICE-TO-ANNOUNCED-DICE SECTION.
           INITIALIZE ROLL-COMPARE-FLAGS
           IF DICE-1 IN ANNOUNCED-DICE = DICE-2 IN ANNOUNCED-DICE
           THEN
              SET PASCH-ANNOUNCED TO TRUE
           END-IF
           IF DICE-1 IN ROLLED-DICE = DICE-2 IN ROLLED-DICE
           THEN
              SET PASCH-ROLLED TO TRUE
           END-IF

           EVALUATE TRUE ALSO TRUE
           WHEN DICE-1 IN ROLLED-DICE = 2 ALSO
                DICE-2 IN ROLLED-DICE = 1
                SET MAEXCHEN-ROLLED TO TRUE
                SET MY-DICE-IS-HIGHER TO TRUE
           WHEN PASCH-ROLLED ALSO
                PASCH-ANNOUNCED
                IF DICE-1 IN ROLLED-DICE > DICE-1 IN ANNOUNCED-DICE
                THEN
                  SET MY-DICE-IS-HIGHER TO TRUE
                ELSE
                  SET MY-DICE-IS-LOWER TO TRUE
                END-IF
           WHEN PASCH-ANNOUNCED ALSO ANY
                SET MY-DICE-IS-LOWER TO TRUE
           WHEN DICE-1 IN ROLLED-DICE > DICE-1 IN ANNOUNCED-DICE
                ALSO ANY
                SET MY-DICE-IS-HIGHER TO TRUE
           WHEN OTHER
                SET MY-DICE-IS-LOWER TO TRUE
           END-EVALUATE
           .
           EXIT.

       END PROGRAM SIMPLBOT.
