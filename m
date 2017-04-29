From: lkp@intel.com (kbuild test robot)
Date: Sat, 29 Apr 2017 13:50:51 +0800
Subject: [PATCH 2/5] clk: qcom: ipq8074: Add Global Clock Controller
 support
In-Reply-To: <1493373403-23462-3-git-send-email-varada@codeaurora.org>
Message-ID: <201704291326.jFi4mgNw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhishek,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.11-rc8 next-20170428]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Varadarajan-Narayanan/Add-minimal-boot-support-for-IPQ8074/20170429-130315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/clk/qcom/gcc-ipq8074.c:1014:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
