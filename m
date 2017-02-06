From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 6 Feb 2017 22:31:35 +0800
Subject: [xlnx:master 2187/2699] grep:
 include/linux/mali/mali_utgard_uk_types.h: No such file or directory
Message-ID: <201702062230.IjRryUcQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radhey,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   629041605b93343ad2e8971ceaac3edcef0b043b
commit: c42f4bd4baad59c73cc855fbf9e78edd61163d60 [2187/2699] staging: mali: Fix Kbuild error for make O= option
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout c42f4bd4baad59c73cc855fbf9e78edd61163d60
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   /bin/sh: 1: cd: can't cd to drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali
   /bin/sh: 1: cd: can't cd to drivers/staging/mali/DX910-SW-99002-r5p2-00rel0/driver/src/devicedrv/mali
   /bin/sh: 1: cd: can't cd to drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali
   /bin/sh: 1: cd: can't cd to drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali
   /bin/sh: 1: cd: can't cd to drivers/staging/mali/DX910-SW-99002-r5p2-00rel0/driver/src/devicedrv/mali
   /bin/sh: 1: cd: can't cd to drivers/staging/mali/DX910-SW-99002-r5p2-00rel0/driver/src/devicedrv/mali
   /bin/sh: 1: cd: can't cd to drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali
>> grep: include/linux/mali/mali_utgard_uk_types.h: No such file or directory
   /bin/sh: 1: cd: can't cd to drivers/staging/mali/DX910-SW-99002-r5p2-00rel0/driver/src/devicedrv/mali
>> grep: include/linux/mali/mali_utgard_uk_types.h: No such file or directory

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49028 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/965e44e5/attachment-0001.gz>
