From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 13 Dec 2017 21:03:02 +0800
Subject: [xlnx:2017.3_video_ea 6585/6607] warning: (VIDEO_XILINX_HDMI_RX &&
 ..) selects PHY_XILINX_VPHY which has unmet direct dependencies (STAGING &&
 ..)
Message-ID: <201712132141.Q45p1LSp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx 2017.3_video_ea
head:   af045f9682c65a0c26afb2f638603d3c01079222
commit: b58dab7f9cf13f9004a220128317fc85a1b75b63 [6585/6607] staging: xilinx: Add xilinx hdmi drivers to staging area
config: x86_64-randconfig-x013-12131947 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout b58dab7f9cf13f9004a220128317fc85a1b75b63
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

warning: (VIDEO_XILINX_HDMI_RX && DRM_XILINX_HDMI) selects PHY_XILINX_VPHY which has unmet direct dependencies (STAGING && ARCH_ZYNQMP)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24216 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/de4e2d41/attachment-0001.gz>
