From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Nov 2016 17:56:39 +0800
Subject: [PATCH 2/2] irqchip/gicv3-its: Test code for measuring
 Read-allocate
In-Reply-To: <8c3ea714-5bd2-6784-8eae-8b953860c8f6@codeaurora.org>
Message-ID: <201611081703.K5VlCvmj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.9-rc4 next-20161028]
[cannot apply to tip/irq/core arm-jcooper/irqchip/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shanker-Donthineni/irqchip-gicv3-its-Test-code-for-measuring-Read-allocate/20161108-154723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   /tmp/ccEUFgcT.s: Assembler messages:
>> /tmp/ccEUFgcT.s:700: Error: selected processor does not support requested special purpose register -- `mrs r10,pmccntr_el0'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38721 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/f74b1c64/attachment-0001.gz>
