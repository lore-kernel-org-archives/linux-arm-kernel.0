From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Oct 2018 11:13:53 -0300
Subject: [PATCH v2 6/6]  ARM: imx_v4_v5_defconfig: Remove unneeded options
In-Reply-To: <1538576033-23415-1-git-send-email-festevam@gmail.com>
References: <1538576033-23415-1-git-send-email-festevam@gmail.com>
Message-ID: <1538576033-23415-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the following unneeded config options:

- CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS have been removed
since commit a930d8bd94d8d ("usb: chipidea: Always build ULPI code")

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Split into a new patch the config options that were removed

 arch/arm/configs/imx_v4_v5_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index eed5ef0..8661dd9 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -141,11 +141,9 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
-CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-- 
2.7.4
