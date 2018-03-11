From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 11 Mar 2018 11:48:39 +0800
Subject: [xlnx:master 1366/1515] ERROR: "dwc3_set_usb_core_power"
 [drivers/usb/dwc3/dwc3.ko] undefined!
Message-ID: <201803111137.gVABwsWy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajan,

First bad commit (maybe != root cause):

tree:   https://github.com/Xilinx/linux-xlnx master
head:   f445aa62727567784c6e32780d9b13f1011ddc1c
commit: c88530fa0fad13bfd2a005c03ed091a5240f2411 [1366/1515] zynqmp: Use firmware IOCTL for device control
config: i386-randconfig-a1-201810 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout c88530fa0fad13bfd2a005c03ed091a5240f2411
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "dwc3_set_usb_core_power" [drivers/usb/dwc3/dwc3.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27766 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180311/2c0232e5/attachment-0001.gz>
