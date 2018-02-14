From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Feb 2018 09:26:37 +0000
Subject: [PATCH 2/2] arm64: defconfig: add support for Socionext SynQuacer
 based platforms
In-Reply-To: <20180214092637.14047-1-ard.biesheuvel@linaro.org>
References: <20180214092637.14047-1-ard.biesheuvel@linaro.org>
Message-ID: <20180214092637.14047-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support in arm64's defconfig for Socionext SynQuacer based
platforms, by enabling the arch Kconfig symbol, and enabling builtin
support for the ethernet, GPIO and SDHCI controllers

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e718c64c47e4..d69ed5125013 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -56,6 +56,7 @@ CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_STRATIX10=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_SPRD=y
+CONFIG_ARCH_SYNQUACER=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_THUNDER2=y
 CONFIG_ARCH_UNIPHIER=y
@@ -209,6 +210,7 @@ CONFIG_QCOM_EMAC=m
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
+CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_AT803X_PHY=m
@@ -305,6 +307,7 @@ CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_DWAPB=y
+CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_UNIPHIER=y
@@ -450,6 +453,7 @@ CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ACPI=y
+CONFIG_MMC_SDHCI_F_SDH30=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
-- 
2.11.0
