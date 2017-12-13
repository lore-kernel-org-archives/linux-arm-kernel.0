From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 13 Dec 2017 14:28:54 +0800
Subject: [xlnx:2017.3_video_ea 6589/6607] warning: (VIDEO_XILINX && ..)
 selects XILINX_FRMBUF which has unmet direct dependencies (DMADEVICES && ..)
Message-ID: <201712131453.XpXsLquR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx 2017.3_video_ea
head:   af045f9682c65a0c26afb2f638603d3c01079222
commit: 62a7ed2f02d28f73f2c09d61ecbe1f289aecc6e5 [6589/6607] staging: xilinx: mixer: Initial commit of Xilinx Video Mixer IP DRM driver
config: x86_64-randconfig-x008-12131414 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout 62a7ed2f02d28f73f2c09d61ecbe1f289aecc6e5
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

warning: (VIDEO_XILINX && DRM_XILINX && DRM_XILINX_XVMIXER) selects XILINX_FRMBUF which has unmet direct dependencies (DMADEVICES && XILINX_DMA_ENGINES)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24654 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/93e5cdcf/attachment-0001.gz>
