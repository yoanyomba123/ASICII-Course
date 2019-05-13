## Timing Issues
### Synchronous Timing
![image1](images/image3-1.png)
### latch parameters
![image2](images/image3-2.png)
### CLock Uncertainties
![image3](images/image3-3.png)

Clock uncertainties stem from the following
* clock definition
* devices
* power supply
* interconnect
* temperature
* capacitive load
* coupling to adjacent lines

### Clock Nonidealities
Clock Skew
* spatial variation in temporally equivalent clock edges; deterministic + random, T_sk

Clock Jitter
* Temporal variations in consecutive edges of the clock signal + random noise
* cycle-to-cycle (short term) T_js
* long term T_jl

Variation of the pulse width
 * important for level sensitive clocking

### Clock Skew & Jitter
![image1](images/image3-4.png)

![image](images/image3-5.png)

#### Positive & Negative Skew
![image](images/image3-6.png)

#### Timing Constraints
![images](images/image3-7.png)

#### Impact of Jitter
![images](images/image3-8.png)

#### Clock Constraints
![image](images/image3-9.png)

![image](images/image3-10.png)

#### Flip Flop Based Timing
![image](images/image3-11.png)

![image](images/image3-12.png)

![image](images/image3-13.png)

![image](images/image3-14.png)

![image](images/image3-15.png)

### Example: DEC Alpha 21164
clock frequency: 300 Mhz - 9.3 Million Transistor
Total Clock Load: 3.75 nF
Power in clock distribution network: 20 W (out of 50)
Uses 2 level clock distribution
* Single 6-stage driver at the center of a chip
* Secondary buffers drive ledt and right side clock grid in Metal3 and Metal4. Total driver size: 58cm.

![image](images/image3-16.png)

![image](images/image3-17.png)

![image](images/image3-18.png)

#### Self timed and asynchronous design
Functions of clock in synchronous design
* act as completion signal
* ensures the correct ordering of events

Truly asynchronous design
* Completion is ensured by careful timing analysis
* Ordering of events is implicit in logic

Self times design
* Completion ensured by completion signal
* Ordering imposed by handshaking protocol

![image](images/image3-19.png)

![image](images/image3-20.png)

![image](images/image3-21.png)

![image](images/image3-22.png)

![image](images/image3-23.png)

![image](images/image3-24.png)

![image](images/image3-25.png)

![image](images/image3-26.png)

![image](images/image3-27.png)

![image](images/image3-28.png)

![image](images/image3-29.png)

#### Synchronizers & Arbiters
* Arbiter: Circuit to decide which of 2 events occured first
* Synchronizer: Arbiter with clock phi as one of the inputs
* Problem: Circuit HAS to make a decision in limited time - which decision is not important
* Caveat: It is impossible to ensure correct operation
* but we can decrease the error probability at the expense of delay

![image](images/image3-30.png)

![image](images/image3-31.png)

![image](images/image3-32.png)

![image](images/image3-33.png)

![image](images/image3-34.png)

![image](images/image3-35.png)

![image](images/image3-36.png)

![image](images/image3-37.png)

![image](images/image3-38.png)

![image](images/image3-39.png)

![image](images/image3-40.png)
