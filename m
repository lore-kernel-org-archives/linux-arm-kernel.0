From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 28 May 2017 02:59:15 +0800
Subject: [xlnx:master 560/596] ERROR: "dwc3_set_phydata"
 [drivers/usb/dwc3/dwc3.ko] undefined!
Message-ID: <201705280213.iD9vqJTL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4d47e5726038e6535427945805572442e6f0e7b2
commit: 68e6869cfb8154b80ee9ffafd64932971e9d1d07 [560/596] dwc3: Add support for setting USB control registers as phy platform data
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 68e6869cfb8154b80ee9ffafd64932971e9d1d07
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "dwc3_set_phydata" [drivers/usb/dwc3/dwc3.ko] undefined!
   ERROR: "dwc3_enable_hw_coherency" [drivers/usb/dwc3/dwc3.ko] undefined!
   ERROR: "of_add_property" [drivers/usb/dwc3/dwc3-of-simple.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28524 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170528/06bd3c5f/attachment-0001.gz>
