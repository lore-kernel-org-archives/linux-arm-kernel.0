From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jan 2016 22:48:17 +0800
Subject: [PATCH] clk: Move vendor's Kconfig into CCF menu section
In-Reply-To: <1453879563-39500-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <201601272222.hUOd7aUE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.5-rc1 next-20160127]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/James-Liao/clk-Move-vendor-s-Kconfig-into-CCF-menu-section/20160127-152850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

warning: (ARCH_EXYNOS7) selects COMMON_CLK_SAMSUNG which has unmet direct dependencies (COMMON_CLK)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46703 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/6190b6e1/attachment-0001.obj>
