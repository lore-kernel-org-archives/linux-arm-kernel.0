From: lkp@intel.com (kbuild test robot)
Date: Fri, 13 Apr 2018 14:03:59 +0800
Subject: [PATCH 3/5] net: stmmac: dwmac-sun8i: Allow getting syscon
 regmap from device
In-Reply-To: <20180411141641.14675-4-icenowy@aosc.io>
References: <20180411141641.14675-4-icenowy@aosc.io>
Message-ID: <201804131338.J3POccon%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.16 next-20180412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Icenowy-Zheng/Add-support-in-dwmac-sun8i-for-accessing-EMAC-clock/20180413-004816
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c:82:24: sparse: symbol 'old_syscon_reg_field' was not declared. Should it be static?
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c:89:24: sparse: symbol 'single_reg_field' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
