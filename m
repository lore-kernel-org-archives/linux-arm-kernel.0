From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 30 Oct 2013 22:10:40 +0800
Subject: [PATCH 0/2] mmc: sdhci-esdhc-imx: adding eMMC HS200 mode support
Message-ID: <1383142242-24989-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tuning in latest tree is broken.
This patch fixed it and add HS200 support for imx usdhc.

Patch 2 had been sent out in:
[PATCH 0/7] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr not supported on sabresd issues
No changes since that.

Dong Aisheng (2):
  mmc: sdhci: replace msleep with mdelay for tuning
  mmc: sdhci-esdhc-imx: add eMMC HS200 mode support

 drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
 drivers/mmc/host/sdhci.c           |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

-- 
1.7.2.rc3
