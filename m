From: lkp@intel.com (kbuild test robot)
Date: Sun, 4 Mar 2018 05:58:56 +0800
Subject: [PATCH v7 08/13] arm64: Add support for ACPI based firmware tables
In-Reply-To: <20180228220619.6992-9-jeremy.linton@arm.com>
References: <20180228220619.6992-9-jeremy.linton@arm.com>
Message-ID: <201803040538.WEhZAEzX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.16-rc3 next-20180302]
[cannot apply to arm64/for-next/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jeremy-Linton/Support-PPTT-for-ARM64/20180304-005730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: s390-default_defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All errors (new ones prefixed by >>):

   drivers/base/cacheinfo.o: In function `acpi_find_last_cache_level':
>> (.text+0x900): multiple definition of `acpi_find_last_cache_level'
   arch/s390/kernel/cache.o:(.text+0xc8): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 17664 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180304/9c07f3bf/attachment-0001.gz>
