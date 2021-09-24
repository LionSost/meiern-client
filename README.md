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

![Sequenz-Diagramm](http://www.plantuml.com/plantuml/png/lLNTZff05Bu_J_4zG4tQNchIB869iQ7GCDXcBsVnr4wAWu5nRmplNWQmn2AiJJTBp6YOy_sSRtvygAmgxUcG4nsR7phJHsKi99VFN5wzydFDnXAPmZ9AlVzfKVou57PVK1PPMuPdLMhrbFCIKYJVHBBu8gJqre8w6bTPTPYXiYzPfF6Y0n6R7PmUNGGMdteVIoIyrvKjDPSdiqSYrXkPYaG4w2LSROTQ4kL5SSGjadWR1P2fbwIRQBqws-8NcnfppvWUd-DDD629W5ab4QpEPN5olPqEJrpMgtDM70uA5H-vL9Pto7NLnclKWQkQWB4eG83ABJ9bCiuR407JohuN-I9ifLbLXQaxWblC171USJVT9lSUje21rOqR0cxhV0szHv4qSc4eLsVdlCP_FGJSDDY-dxJXHL7Ji2-2tiFglDCPVtZdne_rB2URtS0zaUPZl4sGRfDXmU_hG-MsZOQ02Gljz1zMkaA_JU8ptkwnuto8u3hlYPJkbnuMz3RnbB7xjyGhnzGV7Ya4ZK2JmAPwrD08DRa1ldjHAf76JhHlSLuE_oBY-UdM2n5i_bg2rzJe6mbZcVODNEwfbrG036Ut7yVyqeyJyS8rkpmMsjY9svRGVXp_GpEuFypV)
  
  
