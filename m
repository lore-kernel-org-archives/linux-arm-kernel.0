From: lkp@intel.com (kbuild test robot)
Date: Mon, 30 Jul 2018 06:00:44 +0800
Subject: [PATCH v3 4/5] pinctrl: actions: Add Actions Semi S700 pinctrl
 driver
In-Reply-To: <20180729200038.11795-5-sravanhome@gmail.com>
References: <20180729200038.11795-5-sravanhome@gmail.com>
Message-ID: <201807300552.cJ0VSU1K%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pinctrl/devel]
[also build test WARNING on next-20180727]
[cannot apply to v4.18-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/Add-Actions-Semi-S700-pinctrl-support/20180730-040252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pinctrl/actions/pinctrl-s700.c:228:31: sparse: symbol 's700_pads' was not declared. Should it be static?
>> drivers/pinctrl/actions/pinctrl-s700.c:1552:30: sparse: symbol 's700_functions' was not declared. Should it be static?
>> drivers/pinctrl/actions/pinctrl-s700.c:1700:20: sparse: symbol 's700_padinfo' was not declared. Should it be static?
   drivers/pinctrl/actions/pinctrl-s700.c:1589:10: sparse: Initializer entry defined twice
   drivers/pinctrl/actions/pinctrl-s700.c:1594:10:   also defined here

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
