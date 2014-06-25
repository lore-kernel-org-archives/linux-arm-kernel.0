From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jun 2014 17:28:53 -0300
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: Add USB device options
In-Reply-To: <1403728133-12487-1-git-send-email-festevam@gmail.com>
References: <1403728133-12487-1-git-send-email-festevam@gmail.com>
Message-ID: <1403728133-12487-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Allow USB device to work by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 68abce9..090de01 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -159,6 +159,8 @@ CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_ETH=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-- 
1.8.3.2
