From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jan 2016 01:26:48 +0800
Subject: [PATCH] mtd: avoid stack overflow in MTD CFI code
In-Reply-To: <1453736525-1959191-3-git-send-email-arnd@arndb.de>
Message-ID: <201601260121.3Blbm5Kw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on v4.5-rc1]
[also build test WARNING on next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/mtd-avoid-stack-overflow-in-MTD-CFI-code/20160125-234611
config: um-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All warnings (new ones prefixed by >>):

warning: (MTD_MAP_BANK_WIDTH_32) selects MTD_COMPLEX_MAPPINGS which has unmet direct dependencies (MTD && HAS_IOMEM)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 17797 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160126/dc6b907a/attachment-0001.obj>
