From: lkp@intel.com (kbuild test robot)
Date: Sat, 10 Dec 2016 02:27:50 +0800
Subject: [PATCH v3 08/12] mmc: sdhci-xenon: Add support to PHYs of
 Marvell Xenon SDHC.
In-Reply-To: <fd1e454d2d8c30c4b191ae78e911d481315352e0.1481279228.git-series.gregory.clement@free-electrons.com>
Message-ID: <201612100213.2R0DRXrE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hu,

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/mmc-Add-support-to-Marvell-Xenon-SD-Host-Controller/20161210-002602
base:    


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mmc/host/sdhci-xenon-phy.c:469:9-10: WARNING: return of 0/1 in function 'emmc_phy_slow_mode' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
