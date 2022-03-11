# 3dScannerApp_samples

A set of MATLAB scripts to work with data collected using [3D Scanner App](https://apps.apple.com/us/app/3d-scanner-app/id1419913995).

![results](https://github.com/PyojinKim/3dScannerApp_samples/blob/main/result.png)


## Usage

To access the data from your iOS device, you can use the data export function in the app.
It is noteworthy that the reliable (effective) depth range is up to about 4.5 m as described [here](https://www.it-jim.com/blog/iphones-12-pro-lidar-how-to-get-and-interpret-data/).
In my personal experience, iPhone/iPad LiDAR (depth map) shows much better depth quality than Intel RealSense L515.


## Notes on Data Acquisition

- Lock the screen orientation on iPhone/iPad (Rotation Lock button)
- Turn the charging port to the right side (x-axis towards the bottom where the lightning cable is)
- Export the data with zip files (on) and z-axis up (off)


## Reference

- Introduction to the [3D Scanner App](https://apps.apple.com/us/app/3d-scanner-app/id1419913995) (https://3dscannerapp.com/)
