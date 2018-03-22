From: lkp@intel.com (kbuild test robot)
Date: Thu, 22 Mar 2018 15:42:17 +0800
Subject: [PATCH net-next 06/12] net: stmmac: dwmac-sun8i: Use
 regmap_field for syscon register access
In-Reply-To: <20180317092857.4396-7-wens@csie.org>
References: <20180317092857.4396-7-wens@csie.org>
Message-ID: <201803221541.uip2NtFU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20180309]
[also build test WARNING on v4.16-rc6]
[cannot apply to v4.16-rc4 v4.16-rc3 v4.16-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/ARM-sun8i-r40-Add-Ethernet-support/20180318-161723
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c:82:24: sparse: symbol 'sun8i_syscon_reg_field' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
