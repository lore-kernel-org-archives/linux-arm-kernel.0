From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 21:13:22 +0800
Subject: [xlnx:2017.2_video_ea 11/28] warning: (VIDEO_XILINX_HDMI_RX && ..)
 selects PHY_XILINX_VPHY which has unmet direct dependencies (STAGING && ..)
Message-ID: <201708032121.nduGOIdG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx 2017.2_video_ea
head:   d9c9ef883408d0622d075cc2ca805d7d96d5b28b
commit: c33ee6950b34e8b00d9c77238dd7dfe0789dc91f [11/28] staging: xilinx: Add xilinx hdmi drivers to staging area
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c33ee6950b34e8b00d9c77238dd7dfe0789dc91f
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/021e2716/attachment-0001.gz>
