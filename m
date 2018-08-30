From: lkp@intel.com (kbuild test robot)
Date: Fri, 31 Aug 2018 01:05:12 +0800
Subject: [PATCH v5 5/5] arm64: dts: actions: Add pinctrl node for Actions
 Semi S700
In-Reply-To: <20180829082413.2512005-6-sravanhome@gmail.com>
References: <20180829082413.2512005-6-sravanhome@gmail.com>
Message-ID: <201808302331.VZAH3yDm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pinctrl/devel]
[also build test ERROR on v4.19-rc1 next-20180830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/Add-Actions-Semi-S700-pinctrl-support/20180830-134355
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   Error: arch/arm64/boot/dts/actions/s700.dtsi:172.19-20 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60987 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/e87a9fb0/attachment-0001.gz>
