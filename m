From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 17 Aug 2016 02:08:42 +0800
Subject: [shawnguo:imx/dt 15/22] ERROR: Input tree has errors, aborting (use
 -f to force output)
Message-ID: <201608170226.eMaKynUU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/dt
head:   aa4eab4468913b80fbed464abf1b94d64f0bb7cc
commit: 7f876822566dc2dd9fde51940941676651eacaef [15/22] ARM: dts: imx7s: Add SAI nodes
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7f876822566dc2dd9fde51940941676651eacaef
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the shawnguo/imx/dt HEAD aa4eab4468913b80fbed464abf1b94d64f0bb7cc builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 38534 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160817/7e8beacf/attachment-0001.obj>
