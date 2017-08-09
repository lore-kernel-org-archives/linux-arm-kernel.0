From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 10 Aug 2017 04:08:12 +0800
Subject: [arm64:for-next/core 9/14] make[2]: *** No rule to make target
 'arch/arm64/lib/uaccess_flushcache.o', needed by 'arch/arm64/lib/lib.a'.
Message-ID: <201708100408.h7QOkxy5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
head:   6ec4e2514decd6fb4782a9364fa71d6244d05af4
commit: 5d7bdeb1eeb250222304cb7b8126892cc47980a8 [9/14] arm64: uaccess: Implement *_flushcache variants
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5d7bdeb1eeb250222304cb7b8126892cc47980a8
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> make[2]: *** No rule to make target 'arch/arm64/lib/uaccess_flushcache.o', needed by 'arch/arm64/lib/lib.a'.
   make[2]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56879 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/6461cc10/attachment-0001.gz>
