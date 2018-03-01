From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 2 Mar 2018 00:16:27 +0800
Subject: [xlnx:master 1140/1438] warning: (MACB && ..) selects PTP_1588_CLOCK
 which has unmet direct dependencies (NET && ..)
Message-ID: <201803020025.B7DIDjmK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   807fdad49dd7b39688d91c60925994956cfafef4
commit: bd5e4254ba46283ee1aa1e04ba498c34ef171e25 [1140/1438] net: xilinx: Remove ancient xilinx_emacpc.c driver
config: x86_64-randconfig-x002-201808 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout bd5e4254ba46283ee1aa1e04ba498c34ef171e25
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

warning: (MACB && XILINX_AXI_EMAC_HWTSTAMP && XILINX_TSN_PTP && XILINX_TSN_QBV) selects PTP_1588_CLOCK which has unmet direct dependencies (NET && POSIX_TIMERS)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28190 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/0ebc1f92/attachment-0001.gz>
