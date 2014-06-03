From: lho@apm.com (Loc Ho)
Date: Tue,  3 Jun 2014 15:13:02 -0600
Subject: [PATCH v2 0/3] mmc: Add APM X-Gene SoC SDHC controller support to
 Arasan SDHCI driver
Message-ID: <1401829985-5212-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC SDHC controller to Arasan
SDHCI driver.

v2:
* Update binding documentation
* Change compatible string from "xgene,arasan" to "apm,arasan"

Signed-off-by: Loc Ho <lho@apm.com>
---
Loc Ho (3):
  Documentation: Update Arasan SDHC documentation for the APM X-Gene
    SoC SDHC DTS binding
  mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI
    driver
  arm64: Add APM X-Gene SoC SDHC controller DTS entry

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   16 ++-
 arch/arm64/boot/dts/apm-storm.dtsi                 |    8 ++
 drivers/mmc/host/Kconfig                           |    4 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  126 ++++++++++++++++++--
 4 files changed, 140 insertions(+), 14 deletions(-)
