# AE_Master_Thesis_Matlab_Code

MATLAB (2019a) code for AE Master Thesis. It is the Lambert problem solver provided initially by Howard D. Curtis (online) and optimized by SJSU Alumni Theodore Hendricks. The 'sample code' titled files were created by Theodore and I to use for project. The 'sample code' titled files calls the Lambert Solver function to be used. Anyone who is interested in using these files must upload them in one folder on PC. The only items that need adjusting, if need be, are the files titled with 'sample code'.

The purpose of the Lambert Solver, (also called Lambert Problem) is to take any two positions, in space, with an estimated time of flight (TOF) (also called the duration of flight) and find the associated velocities that the spacecraft needs to be at in order to reach its expected destination. For example, the two positions are Venus' periapsis and Saturn's periapsis. The Pos1 is the starting point at Venus while Pos2 is the end point at Saturn. The Lambert solver then spits out the associated velocities at those two positions. This is useful if using an orbital simulator, like GMAT, that requires initial position and velocity coordinates. The Lambert Solver's output variable is called 'temp'. 

The Lambert solver is reference frame agnostic. Thus, ephemeris data collected from JPL Horizons should be sun centered. Then collect the first and last positions from that data to input into 'Pos1' and 'Pos2'. Make sure to adjust the offsets accordingly. Note that the ephemeris data is positions of the planets with respect to whatever body of origin you select. Thus, the offsets are with respect to the planets and spacecraft.

Time is also an important factor, so make sure to keep in mind when selecting your dates. If unsure, can use online planetary simulators that showcase the planet's positions with respect to each other at different dates. 

units are:  distance =  km
            velocity = km/s
            time      = s
