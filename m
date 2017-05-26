From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 26 May 2017 22:31:18 +0800
Subject: [xlnx:2017.1_video_ea 11/28] warning: (VIDEO_XILINX_HDMI_RX && ..)
 selects PHY_XILINX_VPHY which has unmet direct dependencies (STAGING && ..)
Message-ID: <201705262214.e2DxezbT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx 2017.1_video_ea
head:   79a0e60e9f6535e89d9923e3987398318f0ed4e2
commit: 2d6e151e6186db912023243302ba4880b00a8bad [11/28] staging: xilinx: Add xilinx hdmi drivers to staging area
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2d6e151e6186db912023243302ba4880b00a8bad
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

warning: (VIDEO_XILINX_HDMI_RX && DRM_XILINX_HDMI) selects PHY_XILINX_VPHY which has unmet direct dependencies (STAGING && ARCH_ZYNQMP)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47264 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170526/f7aa3eff/attachment-0001.gz>
