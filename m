From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 Aug 2017 21:59:08 +0800
Subject: [PATCH v1 1/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <20170822033502.4100-2-brendanhiggins@google.com>
Message-ID: <201708232122.mBCbVCE7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brendan,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.13-rc6 next-20170823]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Brendan-Higgins/arm-npcm-add-basic-support-for-Nuvoton-BMCs/20170824-031106
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

warning: (CPU_NPCM750_SMP) selects ARM_ERRATA_458693 which has unmet direct dependencies (CPU_V7 && !ARCH_MULTIPLATFORM)
warning: (CPU_NPCM750_SMP) selects ARM_ERRATA_742231 which has unmet direct dependencies (CPU_V7 && SMP && !ARCH_MULTIPLATFORM)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170823/8118174d/attachment-0001.gz>
