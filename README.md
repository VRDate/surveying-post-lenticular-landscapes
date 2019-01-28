# Surveying post-lenticular landscapes
A workshop by [Apt Opt Out](https://www.instagram.com/apt.opt.out/).

Here's a list of resources for developing projects with the Kinect. If people miss certain information or have more resources let me know. With this document I hope everyone can find a place to start for making projects with the Kinect.

In the folder [processing](https://github.com/aptoptout/surveying-post-lenticular-landscapes/tree/master/processing) you can find several examples I have prepared and were developed during the workshop.

From Monday, January 28th 2019, there are 2 available MS Kinect's in Hacklab at the Royal Academy of Art. [Here](https://www.gooxbox360.nl/xbox-360-accessoires-kopen/microsoft-kinect/) is a good place to buy secondhand Kinect's where they are first tested before being sold.

### Table of Contents
1. [**Kinect + Processing**](#kinectprocessing)  
[Libraries](#processinglibraries)  
[Beginners Resources](#processingresources)  
[General example repositories](#processingexamplerepo)  
[Body/ Limb/ Gesture tracking](#bodylimbgesturetracking)  
[Depth camera/ 3D scan/ Point cloud/ 3D Mesh](#depthcamerapointcloudmesh)  
[Books](#processingbooksmagazines)  
[Channels](#processingchannels)  
[Documentary Films](#processingdocumentaryfilms)  
[Artists/ Designers /Educators](#processingartistsdesigners)  
0. [**Kinect + Unity**](#kinectunity)  
[Setting up the Kinect and Unity](#kinectunityinstall)  
[Depth camera/ 3D scan/ Point cloud/ 3D Mesh](#kinectdepthcamerapointcloudmesh)  
0. [**MeshLab**](#meshlab)  
0. [**Skanect**](#skanect)  
0. [**List of depth camera's**](#depthcameras)  
0. [**Projects/ Inspiration**](#projectsinspiration)  

---

<a name="kinectprocessing"/>

## Kinect + Processing
In this section I'll link to lots of resources for creating projects with the Kinect and Processing.

There are some general resources in there which focus more on learning Processing, writing Object Oriented Programming or working with vectors. Intentionally I've included such resources here as well since those will help you with any Kinect project as well.

<a name="processinglibraries"/>

### Libraries

SimpleOpenNI [↗](https://github.com/totovr/SimpleOpenNI)  
Open Kinect for Processing [↗](https://github.com/shiffman/OpenKinect-for-Processing)  

<a name="processingresources"/>

### Beginners Resources

The Nature of Code (Vimeo) [↗](https://vimeo.com/channels/natureofcode)  
Kinect and Processing tutorail (Youtube) [↗](https://www.youtube.com/watch?v=QmVNgdapJJM&list=PLRqwX-V7Uu6ZMlWHdcy8hAGDy6IaoxUKf)  
Learning Processing: A Beginner's Guide to Programming Images, Animation and Interaction [↗](https://www.youtube.com/user/shiffman/playlists?sort=dd&shelf_id=2&view=50)  
Hello Processing [↗](https://hello.processing.org)  

<a name="processingexamplerepo"/>

### General example repositories

Open Processing [↗](https://www.openprocessing.org)  
Daniel Shiffman Kinect examples [↗](https://github.com/CodingTrain/website/tree/master/Tutorials/Processing/12_kinect)  

<a name="bodylimbgesturetracking"/>

### Body/ Limb/ Gesture tracking
Finger tracking [↗](https://github.com/atduskgreg/FingerTracker)  
Hand tracking [↗](https://forum.processing.org/two/discussion/18846/resolved-hand-tracking-with-kinect-processing)  
Hand drawing (by tracking) [↗](https://forum.processing.org/two/discussion/9553/hand-drawing-on-the-kinect)  
Body tracking (skeletonization) [↗](https://github.com/antoine1000/kinect-skeleton)  
Body tracking (skeletonization) 2 [↗](http://urbanhonking.com/ideasfordozens/2011/02/16/skeleton-tracking-with-kinect-and-processing/)  

<a name="depthcamerapointcloudmesh"/>

### Depth camera/ 3D scan/ Point cloud/ 3D Mesh
Draw mesh from point cloud [↗](http://therandomlab.blogspot.com/2013/01/visualizing-kinects-3d-mesh-with.html)  
Kinect 3D Face Morphing [↗](http://developkinect.com/news/visual-effects/kinect-3d-face-morphing-processing-sketch)  

<a name="processingbooksmagazines"/>

### Books
The Nature of Code – Daniel Shiffman [↗](https://natureofcode.com/)  
Making Things See – Greg Borenstein [↗](http://www.hmangas.com/Electronica/Datasheets/Arduino/LIBROS%20Y%20MANUALES/[Making.Things.See(2012.01)].Greg.Borenstein.pdf)  

<a name="processingchannels"/>

### Channels
Coding Train [↗](https://www.youtube.com/channel/UCvjgXvBlbQiydffZU7m1_aw)  
Coding Math [↗](https://www.youtube.com/user/codingmath)  
Fun Programming [↗](https://funprogramming.org/)  

<a name="processingdocumentaryfilms"/>

### Documentary Film
Hello World! Processing [↗](https://vimeo.com/60735314)  

<a name="processingartistsdesigners"/>

### Artists/ Designers /Educators
Josh Blake [↗](http://nui.joshland.org/)  
Greg Borenstein [↗](http://gregborenstein.com/)  
Nicolas Burrus [↗](http://nicolas.burrus.name/)  
Ben Fry [↗](https://benfry.com/)  
Robert Hodgin [↗](http://roberthodgin.com/)  
Oliver Kreylos [↗](http://doc-ok.org/)  
Zach Lieberman [↗](https://www.instagram.com/zach.lieberman/)  
Kyle McDonald [↗](http://kylemcdonald.net/)  
Casey Reas [↗](http://reas.com/)  
Daniel Shiffman [↗](https://shiffman.net/)  
Elliot Woods [↗](https://www.kimchiandchips.com/works/)  

---

<a name="kinectunity"/>

## Kinect + Unity
In this section I'll explain how to install the correct drivers and middleware to setup the _Kinect_ (v1) with _Unity_ (on Mac OSX). If you have resources that would fit this section please let me know.

<a name="kinectunityinstall">

### Setting up the Kinect and Unity
#### Step 1: Disable System Integrity Proctection

System Integrity Protection (SIP) is a new default security measure introduced by Apple in OS X 10.11 onward. This rootless feature prevents Mac OS X compromise by malicious code, therefore locking down specific system level locations in the file system. This prevents the user from making changes to the system via Sudo commands. Therefore in order for us to proceed, we need to turn it off.

1. Restart your Mac in Recovery mode (Restart your Mac holding down Cmd-R)
2. Find _Terminal_ in the _Utilities_ menu and type in the following : `csrutil disable`
3. Restart your mac

**Now we have full access to install the right software.**

#### Step 2: Download and install MacPorts & Brew

1. Visit http://www.macports.org/install.php, download and install MacPorts (follow instruction on their website).
2. Visit https://brew.sh/, download and install Brew (follow instruction on their website).

#### Step 3: Install Dependencies

1. Open _Terminal_
2. Type: `sudo port install libtool`
3. Restart your mac
4. Open _Terminal_ again
5. Type: `brew install libusb`
6. Restart your mac again

#### Step 4: Install OpenNI

1. Go to a folder where you'd like to store all the Kinect software (e.g. 'Documents')
2. Create a new folder called 'Kinect'
3. Download this version of [OpenNI](https://mega.nz/#!yJwg1DJS!uJiLY4180QGXjKp7sze8S3eDVU71NHiMrXRq0TA7QpU)
4. Move the Zip file to your Kinect folder and double-click to uncompress and reveal the SDK folder.
5. Open Terminal and navigate to the OpenNI SDK folder
6. Once in the folder,  
...first type: `chmod +x install.sh`  
...then type: `sudo ./install.sh`  
...type in your password and let it install  
7. After succesfull installation type this in _Terminal_: `sudo ln -s /usr/local/bin/niReg /usr/bin/niReg`

#### Step 5: Install SensorKinect
1. Go here and download this repository: https://github.com/avin2/SensorKinect
2. Move the downloaded Zip file to the _Kinect_ folder you created earlier and uncompress the Zip inside that folder
3. Navigate to the _SensorKinect093-Bin-MacOSX-v5.1.2.1.tar_ file inside the _Bin_ folder and uncompress it
4. Open Terminal and navigate to the same folder  
...first type: `chmod +x install.sh`  
...then type: `sudo ./install.sh`  
...type in your password and let it install the _Primesense_ sensor

#### Step 6: Install NiTE
1. Last thing to install. [Go here and download](http://cvrlcode.ics.forth.gr/web_share/OpenNI/NITE_SDK/NITE_1.x/) _NiTE-Bin-MacOSX-v1.5.2.21.tar.zip_
2. Add this file to your _Kinect_ folder and uncompress it
3. Go into _Terminal_ and navigate to the _NiTE_ folder
4. Install NiTE by typing in the following commands  
...first type: `chmod +x install.sh`  
...then type: `sudo ./install.sh`  
...type in your password and let it install the _Primesense_ sensor

#### Step 7: Checking if everything works
Now try and run some examples!

1. Plug in the Kinect
2. Copy the sample XML files from NiTE/Data over to the Data folder in SensorKinect
3. Open Terminal and navigate to NiTE/Samples/Bin/x64-Release
4. Run the first Demo by typing in the following command  
...`./Sample-PointViewer`  

If everything is setup correctly then a new window should pop up and display a tracking demo! 

#### Step 8: Turn on the SIP again:  
1. Restart your Mac in _Recovery mode_ (Restart your Mac holding down Cmd-R)
2. Find _Terminal_ in the _Utilities_ menu and type in the following : `csrutil enable`
3. Restart your mac

#### Step 9: Running Kinect inside Unity
Finally we can get access to the Kinect from inside Unity, we just have to get the right bindings between the sensor and Unity.

1. Download the _Unity_ package [located here](https://github.com/aptoptout/surveying-post-lenticular-landscapes/tree/master/unity).
2. Import that _Unity_ package in a new or existing project.
3. There are some example scenes you can open to see if and how it works.

I will keep writing my findings on how to use these scripts to get certain things done. Also this should be provide the right foundation to find other examples that make use of the Kinect in Unity and run those projects without (much) problems.

[source 1](https://www.macports.org/install.php), [source 2](https://storage.googleapis.com/goog...ple-openni/OpenNI_NITE_Installer-OSX-0.24.zip), [source 3](https://web.archive.org/web/20170607225336/http://zigfu.com/en/downloads/legacy/), [source 4](http://developkinect.com/resource/package-installer/zigfu-package-installer), [source 5](https://forum.unity.com/threads/kinect-for-osx.104760/), [source 5](http://developkinect.com/resource/mac-os-x/install-openni-nite-and-sensorkinect-mac-os-x), [source 6](https://creativevreality.wordpress.com/2016/01/26/setting-up-the-kinect-on-osx-el-capitan/)

<a name="kinectdepthcamerapointcloudmesh"/>

### Depth camera/ 3D scan/ Point cloud/ 3D Mesh

Point Cloud Data with Unity [↗](https://blog.sketchfab.com/tutorial-processing-point-cloud-data-unity/)  

---

<a name="meshlab"/>

## MeshLab
Turning point cloud into mesh in MeshLab [↗](http://gmv.cast.uark.edu/scanning/point-clouds-to-mesh-in-meshlab/)  

---

<a name="skanect"/>

## Skanect
Skanect (turn Kinect in 3D scanner) [↗](https://skanect.occipital.com/)  

---

<a name="depthcameras"/>

## List of depth camera's
Microsoft Kinect V1 (out of production) [↗](https://developer.microsoft.com/nl-nl/windows/kinect)  
Microsoft Kinect V2 (out of production) [↗](https://developer.microsoft.com/nl-nl/windows/kinect)  
Intel RealSense [↗](https://www.intel.com/content/www/us/en/architecture-and-technology/realsense-overview.html)  
Orbbec Astra Pro [↗](https://orbbec3d.com/product-astra-pro/)  
Orbbec Persee [↗](https://orbbec3d.com/product-persee/)  
VicoVR [↗](https://vicovr.com/)  
Stereolabs ZED [↗](https://www.stereolabs.com/zed/)  
Xtion PRO [↗](https://www.asus.com/3D-Sensor/Xtion_PRO/)  

---

<a name="projectsinspiration"/>

## Projects/ Inspiration
ScanLAB Projects [↗](https://scanlabprojects.co.uk/)  
Ben Snell – Lidar photography [↗](http://bensnell.io/lidar-photography/)  
Charles Matz & Jonathan Michael Dillon – Traces [↗](https://www.dailydot.com/debug/lidar-art-ethiopia-nyit/)  
Pacific Heights – Buried By The Burden [↗](https://www.youtube.com/watch?v=XBUdCBxrhZo)  
PajamaClub – TNT For Two [↗](https://www.youtube.com/watch?v=fG9y52tWTDw)  
Custom Logic – The Motion Project [↗](https://www.custom-logic.com/work/the_motion_project/)  
Radiohead – House of Cards [↗](https://www.youtube.com/watch?v=8nTFjVm9sTQ)  

---

<a name="kinectvanilla">

## Kinect vanilla
With Kinect vanilla I mean accessing the sensor without the use of any additional frameworks, software or libraries other than its own drivers, middleware and language wrappers. This way allows you to get more control over the sensor and make use of all the equipment inside such as the microphone array.

To install everything for Kinect vanilla follow the installation process shown in [_Setting up the Kinect and Unity_](#kinectunityinstall) until step 7.