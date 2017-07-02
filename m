From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 3 Jul 2017 01:28:13 +0800
Subject: [xlnx:master 560/710] core.c:undefined reference to `dwc3_set_phydata'
Message-ID: <201707030112.KgI8MADZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   ae4bbf82f4b9fdfc85b3fd112696e8bbefff07f2
commit: 68e6869cfb8154b80ee9ffafd64932971e9d1d07 [560/710] dwc3: Add support for setting USB control registers as phy platform data
config: i386-randconfig-s1-07012130 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 68e6869cfb8154b80ee9ffafd64932971e9d1d07
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `dwc3_core_init':
   core.c:(.text+0x1481e4): undefined reference to `dwc3_enable_hw_coherency'
   drivers/built-in.o: In function `dwc3_probe':
>> core.c:(.text+0x149373): undefined reference to `dwc3_set_phydata'
   core.c:(.text+0x1493d5): undefined reference to `dwc3_set_phydata'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26386 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170703/94e5195f/attachment-0001.gz>
