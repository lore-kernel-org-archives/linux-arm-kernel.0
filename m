From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:18 +0200
Subject: [PATCH 12/12] arm64: defconfig: Add Xenon sdhci
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465456218-28354-13-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Xenon sdhci found on Armada 37xx and Armada 7K/8K SoCs

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d0491e..2fe02461be55 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -245,6 +245,7 @@ CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_XENON_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_TEGRA=y
-- 
2.5.0
