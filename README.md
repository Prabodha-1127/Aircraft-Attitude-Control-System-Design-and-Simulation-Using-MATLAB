# Aircraft Attitude Control System Design and Simulation Using MATLAB

## Overview

This project presents the design and computer simulation of a closed-loop aircraft attitude control system using MATLAB.

Aircraft attitude control is essential for maintaining the desired orientation of an aircraft during flight. In modern fly-by-wire systems, control surfaces such as ailerons, rudders, and elevators are actuated using electric motors and electronic control units. This project focuses on the position control of a control surface using classical control system design techniques.

The system is modeled using a DC motor, gear train, feedback sensors, and control electronics. Time-domain and frequency-domain analyses are performed to evaluate system performance under various damping conditions and controller configurations.

---

## Objectives

- Derive the open-loop transfer function of the aircraft control surface actuator.
- Obtain the closed-loop transfer function.
- Analyze overdamped, critically damped, and underdamped responses.
- Evaluate time-domain characteristics:
  - Rise Time
  - Settling Time
  - Percentage Overshoot
  - Steady-State Error
- Perform frequency-domain analysis using Bode plots.
- Determine:
  - Resonant Peak
  - Bandwidth
  - Gain Margin (GM)
  - Phase Margin (PM)
  - Crossover Frequencies
- Design and tune a PD controller.
- Verify system stability using:
  - Routh-Hurwitz Criterion
  - Step Response Analysis
  - Frequency Response Analysis

---

## System Model

The aircraft control surface actuator is represented by a DC motor-driven closed-loop control system.

### Open-Loop Transfer Function

G(s) = 9K / [s(s + 0.7224)]

where:

- K = Adjustable gain
- a = 9
- b = 0.7224

### Closed-Loop Transfer Function

T(s) = G(s) / (1 + G(s))

---

## Control System Analysis

### Time-Domain Analysis

The following response characteristics were investigated:

- Overdamped Response
- Critically Damped Response
- Underdamped Response

Performance metrics:

- Rise Time
- Overshoot
- Settling Time
- Steady-State Error

---

### Frequency-Domain Analysis

Bode plots were generated to evaluate:

- Magnitude Response
- Phase Response
- Resonant Peak
- Bandwidth
- Gain Margin
- Phase Margin
- Stability Margins

---

## Controller Design

### Selected Controller

A PD (Proportional-Derivative) Controller was selected because it:

- Improves response speed
- Reduces overshoot
- Enhances damping
- Improves stability margins
- Maintains smooth transient performance

### Tuned Controller Parameters

| Parameter | Value |
|------------|---------|
| Kp | 1.5 |
| Ki | 0 |
| Kd | 2.0 |

---

## Final Performance

### Time-Domain Results

| Metric | Value |
|----------|----------|
| Rise Time | 0.27 s |
| Overshoot | 2.85 % |
| Settling Time | 1.21 s |
| Steady-State Error | 0 |

### Frequency-Domain Results

| Metric | Value |
|----------|----------|
| Phase Margin | 86.87° |
| Gain Margin | ∞ dB |
| Phase Crossover Frequency | 7.25 rad/s |
| Gain Crossover Frequency | Not Defined |

---

## Tools Used

- MATLAB
- Control System Toolbox
- Classical Control Theory
- Routh-Hurwitz Stability Analysis
- Frequency Response Analysis

---

## Key Learning Outcomes

- Transfer function modeling of electromechanical systems
- Closed-loop control system design
- Stability analysis using classical methods
- Controller selection and tuning
- Time-domain and frequency-domain performance evaluation
- Aircraft actuator control system simulation

---

## Author

**R.G.P.M. Rammandala**
Department of Electrical and Electronic Engineering
University of Jaffna

Course: EC5030 – Control Systems

---

## License

This project was developed for academic and educational purposes.
