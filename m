From: lkp@intel.com (kbuild test robot)
Date: Tue, 23 Aug 2016 20:18:03 +0800
Subject: [PATCH v1 1/5] dma: Add QorIQ qDMA engine driver support
In-Reply-To: <1471502328-28305-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <201608232035.33CTgojc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuan,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.8-rc3 next-20160823]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Yuan-Yao/dma-Add-QorIQ-qDMA-engine-driver-support/20160818-152520


coccinelle warnings: (new ones prefixed by >>)

>> drivers/dma/qoriq-qdma.c:879:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
