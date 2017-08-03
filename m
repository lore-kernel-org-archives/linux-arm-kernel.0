From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 10:53:30 +0800
Subject: [xlnx:master 841/864] ERROR: "dwc3_set_simple_data"
 [drivers/usb/dwc3/dwc3.ko] undefined!
Message-ID: <201708031029.Um9SIoJt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   00346d2eba7634f4fb2c2117ac371e0c104a2870
commit: a4769f84c50a769e655d4bb9c1a8a45586cdc1f4 [841/864] dwc3: Add support for removing vbus when suspended
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a4769f84c50a769e655d4bb9c1a8a45586cdc1f4
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   ERROR: "dwc3_host_wakeup_capable" [drivers/usb/host/xhci-plat-hcd.ko] undefined!
   ERROR: "dwc3_set_phydata" [drivers/usb/dwc3/dwc3.ko] undefined!
   ERROR: "dwc3_enable_hw_coherency" [drivers/usb/dwc3/dwc3.ko] undefined!
>> ERROR: "dwc3_set_simple_data" [drivers/usb/dwc3/dwc3.ko] undefined!
   ERROR: "dwc3_simple_wakeup_capable" [drivers/usb/dwc3/dwc3.ko] undefined!
   ERROR: "of_add_property" [drivers/usb/dwc3/dwc3-of-simple.ko] undefined!
>> ERROR: "dwc3_trace" [drivers/usb/dwc3/dwc3-of-simple.ko] undefined!
>> ERROR: "__tracepoint_dwc3_writel" [drivers/usb/dwc3/dwc3-of-simple.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28524 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/5cc5d79a/attachment-0001.gz>
