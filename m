From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 10 Aug 2017 20:37:00 +0800
Subject: [xlnx:master 838/880] warning: (VIDEO_XILINX && ..) selects
 XILINX_FRMBUF which has unmet direct dependencies (DMADEVICES && ..)
Message-ID: <201708102057.mfBwfyKs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e51604bf16d3aaf13ace953eb434359ba9247a91
commit: cea156c57e58b8af38e7f3a919d78c61a9e2d221 [838/880] media: xilinx: Ensure Video Framebuffer selected by Kconfig
config: x86_64-randconfig-x006-201732 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout cea156c57e58b8af38e7f3a919d78c61a9e2d221
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

warning: (VIDEO_XILINX && DRM_XILINX) selects XILINX_FRMBUF which has unmet direct dependencies (DMADEVICES && XILINX_DMA_ENGINES)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25000 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/afc20f49/attachment-0001.gz>
