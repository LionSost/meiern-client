COBOL Maexchen Client
============

A dummy implementation of a Maexchen Client in COBOL.

Content
----------
- **CLIENT.cbl** A helper module to communicate with the Maexchen server
  Can be compiled with:
  ```bash
  cobc -x -I copy CLIENT.CBL
  ```
  
  Can be started with:
  ```bash
  ./CLIENT ip port name-of-the-bot BOTPGMNAME
  ```
  e.g.
  ```bash
  ./CLIENT 192.168.42.220 9000 frank DUMMBOT
  ```
- **DUMMBOT.cbl** A stupid bot that always rolls and always announces the rolled dice.
  Compile with:
  ```bash
  cobc -m -I copy DUMMBOT.CBL
  ```
- **SIMPLBOT.cbl** A more elaborate version of the DUMMBOT.cbl.
  
  
