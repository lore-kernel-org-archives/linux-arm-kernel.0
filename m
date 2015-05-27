From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 27 May 2015 18:13:25 +0800
Subject: [PATCH 0/6]  mmc: imx: a few clean up and fixes
Message-ID: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1 is a small clean up.
Patch 2-4 and 6 are small fixes.
Patch 5 add mx6sx support.

Dong Aisheng (6):
  mmc: sdhci-esdhc-imx: merge the same register check into one place
  mmc: sdhci-esdhc-imx: usdhc does not have missing card interrupt issue
  mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
  mmc: sdhci-esdhc-imx: using specific compatible string in binding doc
  mmc: sdhci-esdhc-imx: add imx6sx support
  mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  9 ++++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 44 +++++++++++++++++-----
 2 files changed, 43 insertions(+), 10 deletions(-)

-- 
1.9.1
