From: lkp@intel.com (kbuild test robot)
Date: Thu, 20 Sep 2018 05:49:28 +0800
Subject: [PATCH 1/2] libata: add ledtrig support
In-Reply-To: <1537328730-9156-2-git-send-email-aditya@kobol.io>
References: <1537328730-9156-2-git-send-email-aditya@kobol.io>
Message-ID: <201809200503.I1K1HjLD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aditya-Prayoga/Add-support-per-ATA-port-ledtrigger-on-armada-38x/20180920-002037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/ata/libata-core.c:6101:3-4: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
