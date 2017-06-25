From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 25 Jun 2017 18:50:33 +0800
Subject: [xlnx:master 514/710] ERROR: "dwc3_enable_hw_coherency"
 [drivers/usb/dwc3/dwc3.ko] undefined!
Message-ID: <201706251831.ku4CfMlj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manish,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   ae4bbf82f4b9fdfc85b3fd112696e8bbefff07f2
commit: 3384f40fd94ebab037bd6bd6853d502bef6e6029 [514/710] usb: dwc3: core: Enable CCI support in dwc3 core driver
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3384f40fd94ebab037bd6bd6853d502bef6e6029
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "dwc3_enable_hw_coherency" [drivers/usb/dwc3/dwc3.ko] undefined!
   ERROR: "devm_ioremap_release" [drivers/usb/dwc3/dwc3-of-simple.ko] undefined!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170625/1dd73322/attachment-0001.gz>
