From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 10 Oct 2017 04:00:33 +0800
Subject: [keystone:for_4.15/keystone-dts 5/9] Error:
 arch/arm/boot/dts/keystone-k2g-evm.dts:134.1-15 syntax error
Message-ID: <201710100431.nX0RlePi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_4.15/keystone-dts
head:   81df40a33d11ae90ba4d5f01a8d9caf25af71768
commit: feaca04c4e0bede3d2156f01b8c79fb407a4bcb8 [5/9] ARM: dts: k2g-evm: Enable USB 0 and 1
config: arm-u8500_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout feaca04c4e0bede3d2156f01b8c79fb407a4bcb8
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/keystone-k2g-evm.dts:134.1-15 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22754 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171010/9c748a8e/attachment-0001.gz>
