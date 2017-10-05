From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Oct 2017 00:23:35 +0800
Subject: [xlnx:master 841/1043] core.c:undefined reference to
 `dwc3_set_simple_data'
Message-ID: <201710060032.malauWKb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   f1b1e077d641fc83b54c1b8f168cbb58044fbd4e
commit: a4769f84c50a769e655d4bb9c1a8a45586cdc1f4 [841/1043] dwc3: Add support for removing vbus when suspended
config: i386-randconfig-s0-10032350 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout a4769f84c50a769e655d4bb9c1a8a45586cdc1f4
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `dwc3_core_init':
>> core.c:(.text+0x24776d): undefined reference to `dwc3_set_simple_data'
   core.c:(.text+0x2477a3): undefined reference to `dwc3_enable_hw_coherency'
   drivers/built-in.o: In function `dwc3_probe':
   core.c:(.text+0x248cf3): undefined reference to `dwc3_set_phydata'
   core.c:(.text+0x248d8c): undefined reference to `dwc3_set_phydata'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28152 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171006/3827b313/attachment-0001.gz>
