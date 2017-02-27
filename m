From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 28 Feb 2017 00:48:59 +0800
Subject: [arm-platforms:kvm-arm/testing 24/25] /tmp/ccxfLm2l.s:105: Error:
 selected processor does not support `mrrc p15,0,r0,r1,c9' in ARM mode
Message-ID: <201702280057.EFxJqrpZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/testing
head:   3d9d99cbf83bf1c290e8e9f251fecebfb4c00008
commit: 89d3a013a23103a1d62d9871cdc680eb5129c101 [24/25] perf: PMUv3: Allow the use of the PMUv3 driver on 32bit ARM
config: arm-sa1100 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 89d3a013a23103a1d62d9871cdc680eb5129c101
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   /tmp/ccxfLm2l.s: Assembler messages:
>> /tmp/ccxfLm2l.s:105: Error: selected processor does not support `mrrc p15,0,r0,r1,c9' in ARM mode
>> /tmp/ccxfLm2l.s:159: Error: selected processor does not support `mcrr p15,0,r2,r3,c9' in ARM mode

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23117 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170228/355247b5/attachment-0001.gz>
