From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 11 Mar 2018 07:24:14 +0800
Subject: [xlnx:master 1140/1515] warning: (MACB && ..) selects PTP_1588_CLOCK
 which has unmet direct dependencies (NET && ..)
Message-ID: <201803110709.OvojESuX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   f445aa62727567784c6e32780d9b13f1011ddc1c
commit: bd5e4254ba46283ee1aa1e04ba498c34ef171e25 [1140/1515] net: xilinx: Remove ancient xilinx_emacpc.c driver
config: i386-randconfig-x070-201810 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout bd5e4254ba46283ee1aa1e04ba498c34ef171e25
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

warning: (MACB && XILINX_AXI_EMAC_HWTSTAMP && XILINX_TSN_PTP && XILINX_TSN_QBV) selects PTP_1588_CLOCK which has unmet direct dependencies (NET && POSIX_TIMERS)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29681 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180311/828203fa/attachment-0001.gz>
