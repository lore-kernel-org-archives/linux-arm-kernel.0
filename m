From: lkp@intel.com (kbuild test robot)
Date: Tue, 9 Feb 2016 16:01:24 +0800
Subject: [PATCH 14/14] clk: qcom: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <1454982341-22715-15-git-send-email-sboyd@codeaurora.org>
Message-ID: <201602091500.56m6YCnX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

[auto build test ERROR on ljones-mfd/for-mfd-next]
[also build test ERROR on v4.5-rc3]
[cannot apply to clk/clk-next next-20160208]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/clk_hw-based-clkdev-DT-providers/20160209-095211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "of_clk_add_hw_provider" [drivers/clk/qcom/clk-qcom.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 52114 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/66c7eadc/attachment-0001.obj>
