From: lkp@intel.com (kbuild test robot)
Date: Sun, 4 Mar 2018 21:04:27 +0800
Subject: [PATCH v4 13/22] nvmem: lpc18xx_otp: Convert to use
 devm_nvmem_register()
In-Reply-To: <20180228144106.16363-14-andrew.smirnov@gmail.com>
References: <20180228144106.16363-14-andrew.smirnov@gmail.com>
Message-ID: <201803042052.Y1F9bkSU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc3 next-20180302]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/Verbatim-device-names-and-devm_nvmem_-un-register/20180303-220801


coccinelle warnings: (new ones prefixed by >>)

>> drivers/nvmem/lpc18xx_otp.c:90:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
