From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 3 Sep 2014 20:04:56 +0800
Subject: [PATCH 0/7] mmc: sdhci/imx: a few clean up and fixes
Message-ID: <1409745903-26550-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few clean up and fixes.

Dong Aisheng (7):
  mmc: sdhci-esdhc-imx: remove duplicated lines
  mmc: sdhci-esdhc-imx: usdhc does not have missing card interrupt
    issue
  mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
  mmc: sdhci: do not enable card detect interrupt for gpio cd type
  mmc: sdhci: do not enable card cd wakeup for gpio case
  mmc: sdhci-esdhc-imx: add imx6sx support
  mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl

 drivers/mmc/host/sdhci-esdhc-imx.c |   44 ++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.c           |    8 +++++-
 2 files changed, 41 insertions(+), 11 deletions(-)

-- 
1.7.8
