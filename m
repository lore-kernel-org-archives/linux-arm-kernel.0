From: lkp@intel.com (kbuild test robot)
Date: Thu, 11 Oct 2018 01:08:23 +0800
Subject: [xlnx:master 1944/2013] warning: (VIDEO_XILINX && ..) selects
 XILINX_FRMBUF which has unmet direct dependencies (DMADEVICES)
Message-ID: <201810110119.EWNag2Wl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   7ea1af329aee531681b87b1fba5496337bff680f
commit: 4997e69d915a8d71334f6bfbf30298d96107b52b [1944/2013] dma: xilinx: Move XILINX_FRMBUF out of XILINX_DMA_ENGINES
config: i386-randconfig-i0-10081525 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 4997e69d915a8d71334f6bfbf30298d96107b52b
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

warning: (VIDEO_XILINX && DRM_XILINX) selects XILINX_FRMBUF which has unmet direct dependencies (DMADEVICES)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181011/50f3dc29/attachment-0001.gz>
