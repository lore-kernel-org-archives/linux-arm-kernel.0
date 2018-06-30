From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Jun 2018 18:16:21 +0800
Subject: [PATCH v9 4/6] init: allow initcall tables to be emitted using
 relative references
In-Reply-To: <20180626182802.19932-5-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-5-ard.biesheuvel@linaro.org>
Message-ID: <201806301852.72CeA28I%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc2 next-20180629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/arch-enable-relative-relocations-for-arm64-power-and-x86/20180627-025148
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}: Error: .size expression for .discard does not evaluate to a constant

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57629 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180630/7cdfc10e/attachment-0001.gz>
