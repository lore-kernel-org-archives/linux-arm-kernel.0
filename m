From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Jul 2018 02:52:47 +0800
Subject: [PATCH v5 10/11] clk: mediatek: Add MT6765 clock support
In-Reply-To: <1531817552-17221-11-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-11-git-send-email-mars.cheng@mediatek.com>
Message-ID: <201807180207.ER8P4qsc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Owen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.18-rc5 next-20180717]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mars-Cheng/Add-basic-SoC-support-for-mt6765/20180717-205540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/mediatek/clk-mt6765.c:36:14: sparse: symbol 'cksys_base' was not declared. Should it be static?
>> drivers/clk/mediatek/clk-mt6765.c:37:14: sparse: symbol 'apmixed_base' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
