From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Jun 2018 08:37:09 -0300
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Select ULPI support
Message-ID: <1530013029-15809-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Select CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS so that
USB ULPI can be functional on some boards like that use ULPI
interface.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 054591d..4cd2f4a 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -141,9 +141,11 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
+CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-- 
2.7.4
