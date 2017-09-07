From: lkp@intel.com (kbuild test robot)
Date: Thu, 7 Sep 2017 23:24:56 +0800
Subject: [PATCH v3 1/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <20170906003016.2159-2-brendanhiggins@google.com>
Message-ID: <201709072303.wpwEY62K%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brendan,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.13 next-20170907]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Brendan-Higgins/arm-npcm-add-basic-support-for-Nuvoton-BMCs/20170907-214055
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

warning: (CPU_NPCM750) selects ARM_ERRATA_458693 which has unmet direct dependencies (CPU_V7 && !ARCH_MULTIPLATFORM)
warning: (CPU_NPCM750) selects ARM_ERRATA_742231 which has unmet direct dependencies (CPU_V7 && SMP && !ARCH_MULTIPLATFORM)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63097 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170907/e26a8a1f/attachment-0001.gz>
