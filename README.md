Part 1: 
- For this part, a sequence detector was designed to detect the sequence “00XX1” with overlap using Mealy and Moore FSMs. 

Part 2: 
- Given the bitstream implementation of a black box sequence detector, in this part, the aim was to reverse engineer the finite state machine and implement it in VHDL. After the design implementation, it was implemented on the FPGA board and its behaviour was matched with the black box’s bitstream and the results were verified to match. 
- Observations:
Based on the behaviour of the black box’s bitstream, it was observed that a Mealy machine was implemented in the black box. This is because the output was affected by the input as well as the current state. 
It can be verified from the state diagram that this sequence detector is for overlapping sequence detection of strings containing the sequence “0X001” 
Assuming that X can take values 0 and 1, this sequence detector can detect two distinct sequences: “00001” and “01001”
As seen from the state transition diagram (Figure 5), the minimum sequence length required to generate the correct output from the detector is five.

Part 3: 
- In this part, the aim was to implement a series of incremental upgrades to the elevator state Machine. The elevator is functional within a 4-story building with an elevator.
The elevator doesn’t service floors 1 and 2. It only transitions between floors 0 (basement) and 3. The elevator has call buttons on each floor and four buttons inside the cabin for selecting the desired floor. For simplicity, it was assumed that the call buttons and cabin buttons are wired in parallel, maintaining a 1-to-1 relationship.
- Part 3a:
Elevator transitions were added for floors 1 and 2 so that the elevator could transition between all four floors.
An emergency indication feature was added which activates if the elevator doesn’t reach the desired destination within 20 seconds. The state of emergency is indicated via the blinking of the RGB LED at 4Hz frequency. To reset the elevator from emergency mode and stop the RGB LED from blinking, a keypad press on any key was implemented.
- Part 3b: 
The cabin controller was enhanced by adding the seven-segment display driver which shows the floor at which the elevator is and along with it shows ‘d’/’u’ when the elevator is going down or up. The display shows “Er” indicating emergency when the emergency condition is encountered.

Takeaway:
- Implementing finite-state machines is crucial for a lot of modern-day applications like sequence detection and mechanical state transitions like in the case of an elevator. While designing Mealy machines is easier because of the lesser number of states used in comparison to Moore machines, implementing Moore machines over Mealy machines is preferred in VHDL. This is because we have more control over the behaviour of Moor machines; their output is not impacted by the input.
- Behavioural-level implementation is preferred when designing systems whose behaviour is easier to model than their structural-level implementations, like in the case of sequence detectors. In the case of the hybrid elevator, structural-level implementation was used because of the requirements that required the declaration of components and the implementation of the necessary connections between them. 
