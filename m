From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Tue, 26 Jul 2011 15:06:11 +0800
Subject: [PATCH v2 0/2] set_ios handle vmmc 
Message-ID: <1311663973-23715-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: reuse vmmc

vmmc is controled inside set_ios according to mmc_power_up/down
Brownstone add support of sdio device 8787

Zhangfei Gao (2):
  mmc: sdhci move vmmc to set_ios
  ARM: mmp2: support sdio device 8787

 arch/arm/mach-mmp/brownstone.c |   60 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c       |   27 ++++++++++--------
 include/linux/mmc/sdhci.h      |    1 +
 3 files changed, 74 insertions(+), 14 deletions(-)
