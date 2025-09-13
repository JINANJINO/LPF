# Filter Algorithms

## 📌 Project Overview  

This repository contains **`dataset2` collected from an IMU sensor** and an implementation file `Average_Filter.m` that includes the following filtering algorithms:  

- Average Filter  
- Moving Average Filter  
- Low-pass Filter  

The objective of this project is to demonstrate fundamental filtering techniques for noise reduction and signal smoothing in sensor data.  

---

## 🧮 Filtering Algorithms  

### 1. Average Filter  
The average filter computes the arithmetic mean of the entire dataset to reduce random noise:  

$$
y = \frac{1}{N} \sum_{i=1}^{N} x_i
$$

- `x_i`: Input data  
- `N`: Total number of samples  
- `y`: Average output  

---

### 2. Moving Average Filter  
The moving average filter calculates the average of the most recent \(M\) samples within a sliding window:  

$$
y[n] = \frac{1}{M} \sum_{k=0}^{M-1} x[n-k]
$$

- `x[n]`: Input signal at time step `n`  
- `M`: Window size  
- `y[n]`: Filter output at time step `n`  

---

### 3. Low-pass Filter  
The low-pass filter attenuates high-frequency components while allowing low-frequency signals to pass, which is effective for reducing sensor noise.  

A simple first-order discrete-time low-pass filter is defined as:  

$$
y[n] = \alpha \, x[n] + (1 - \alpha) \, y[n-1]
$$

- `x[n]`: Input signal at time step `n`  
- `y[n]`: Output signal at time step `n`  
- `α ∈ (0,1)`: Filter coefficient (smaller values yield stronger smoothing)  

---

## 📊 Experimental Results  

### Original IMU Data (Offset Removed)  
<img width="544" height="433" alt="IMU Raw Data" src="https://github.com/user-attachments/assets/bda535c1-1f60-498f-b9a6-0800b9905d91" />  

---

### Comparison of Moving Average Filter  
<img width="586" height="524" alt="Moving Average Comparison" src="https://github.com/user-attachments/assets/f5e89701-7404-44b1-97bb-9149f0587a84" />  

In the figure above, the **red curve corresponds to a window size of 20 samples**, while the **blue curve corresponds to a window size of 40 samples**.  

- A larger window size provides stronger noise reduction but introduces a delay, making the filter less responsive to rapid signal changes.  
- A smaller window size follows the variations in the data more closely but results in higher noise levels.  

Thus, **`M = 20`** is more sensitive to signal variations compared to **`M = 40`**, but produces noisier results. On the other hand, **`M = 40`** achieves better noise suppression but is less responsive to rapid changes.  

---

### Comparison of Low-pass Filters with Different α Values  
<img width="607" height="512" alt="Low-pass Filter Comparison" src="https://github.com/user-attachments/assets/6467c799-0e86-448e-adf4-6892796b7ef9" />  

The figure shows the IMU dataset (offset removed) filtered with a **first-order low-pass filter** using two different values of the tuning parameter `α`:  

- **Red curve**: α = 0.3  
- **Blue dashed curve**: α = 0.9  

Observations:  
- With **α = 0.3**, the filter gives more weight to the current measurement, closely following the variations in the dataset.  
- With **α = 0.9**, the filter relies more on past values, resulting in stronger smoothing but introducing a noticeable delay (phase shift).  

Compared to the moving average filter, the low-pass filter allows different weighting between recent and past data points, making it more effective in balancing **noise suppression** and **responsiveness to signal changes**.  

---

## 🎯 Conclusion  

- The **moving average filter** provides effective noise suppression but introduces a trade-off between smoothing and responsiveness depending on the window size.  
- The **low-pass filter** (LPF) addresses this limitation by assigning different weights to recent and past values, offering a better compromise between noise reduction and signal tracking.  

This repository demonstrates how different filtering algorithms can be applied to IMU sensor data, providing insights into the trade-offs between smoothing and responsiveness in signal processing.  
