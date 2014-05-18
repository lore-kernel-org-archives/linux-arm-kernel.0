From: lho@apm.com (Loc Ho)
Date: Sun, 18 May 2014 01:41:55 -0600
Subject: [PATCH 0/3] mmc: Add APM X-Gene SoC SDHC controller support to Arasan
 SDHCI driver
Message-ID: <1400398918-1502-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC SDHC controller to Arasan
SDHCI driver.

Signed-off-by: Loc Ho <lho@apm.com>
---
Loc Ho (3):
  Documentation: Update Arasan SDHC documentation for the APM X-Gene
    SoC SDHC DTS binding
  mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI
    driver
  arm64: Add APM X-Gene SoC SDHC controller DTS entry

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |    9 +-
 arch/arm64/boot/dts/apm-storm.dtsi                 |    8 ++
 drivers/mmc/host/Kconfig                           |    4 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  126 ++++++++++++++++++--
 4 files changed, 134 insertions(+), 13 deletions(-)
