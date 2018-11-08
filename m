From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Nov 2018 08:22:08 +0800
Subject: [xlnx:master 2120/2152] Warning: ffffffff813df6a6: 26 47 es rex.RXB
Message-ID: <201811080803.YzlpgpU3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   b68293ad2c935d09fa4476750f8c378d4896b1c8
commit: 7c9997cc698ba94529884e6b4edbd93d46a4f4be [2120/2152] gpio: Fix the Dual Channel gpio driver removal issue
config: x86_64-randconfig-j3-201844 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 7c9997cc698ba94529884e6b4edbd93d46a4f4be
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> Warning: ffffffff813df6a6: 26 47 es rex.RXB
   Warning: objdump says 2 bytes, but insn_get_length() says 4
   Warning: arch/x86/tools/test_get_len found difference at <set_primary_fwnode>:ffffffff813dfa90

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30387 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181108/7aeac0c3/attachment-0001.gz>
