# installers_plan
the dependance install for the motion planning algorithm

##1.编译
###（1）grid_map_core
Could not find a package configuration file provided by "grid_map_core"
with any of the following names:
grid_map_coreConfig.cmake
grid_map_core-config.cmake
解决办法：
安装：
sudo apt-get update
sudo apt-get -y install ros-kinetic-pcl-ros ros-kinetic-costmap-2d ros-kinetic-grid-map
###（2）ceres求解器
fatal error: ceres/ceres.h: 没有那个文件或目录
解决办法：
bash ./installers_plan/install_ceres.sh
###（3）IPOPT求解器
A required package was not found
Call Stack (most recent call first):
/usr/share/cmake-3.5/Modules/FindPkgConfig.cmake:532 (_pkg_check_modules_internal)
cmake/FindIPOPT.cmake:3 (pkg_check_modules)
CMakeLists.txt:24 (find_package)
解决办法：
先安装cppad：bash ./installers_plan/install_cppad.sh
再安装ipopt：bash ./ipopt_install/install_ipopt.bash
如果编译执行时遇到：/user/bin/ld: 找不到 -lgfortran 
解决办法：
打开终端 -> locate gfortran.so -> sudo cp 含有gfortran.so的目录/该文件gfortran.so /user/local/lib
原因：[]()[找不到软链接原因](https://blog.csdn.net/weixin_43723326/article/details/103427351) ；[]()[找不到软链接](https://www.cnblogs.com/feifanrensheng/p/10039959.html) 系统的默认搜索依赖库路径为，/usr/local/lib。
###（4）benchmark
Could not find a package configuration file provided by "benchmark" with
any of the following names:
benchmarkConfig.cmake
benchmark-config.cmake
解决办法：
bash ./installers_plan/install_googlebenchmark.sh
###（5）rosparam handler
Could not find a package configuration file provided by "rosparam_handler"
with any of the following names:
rosparam_handlerConfig.cmake
rosparam_handler-config.cmake
解决办法：
bash ./installers_plan/install_rosparem_handler.sh
