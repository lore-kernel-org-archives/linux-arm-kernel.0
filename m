From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 27 Dec 2017 12:25:13 +0800
Subject: [clk:clk-next 136/143] drivers/clk/clk-si5351.c:906:6: sparse:
 symbol '_si5351_clkout_reset_pll' was not declared. Should it be static?
Message-ID: <201712271259.pq3B6Kw4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
head:   cf12ed59508b49c2baaccd7cff68d550c5042b58
commit: b26ff127c52c005ac4eb99ebff7bd17c240c2e89 [136/143] clk: si5351: Apply PLL soft reset before enabling the outputs
reproduce:
        # apt-get install sparse
        git checkout b26ff127c52c005ac4eb99ebff7bd17c240c2e89
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
