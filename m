From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 28 Aug 2016 21:33:17 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select the wm8960 codec driver
Message-ID: <1472430797-16787-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Select CONFIG_SND_SOC_WM8960 so that we can have audio functional
by default on imx6ul-evk and imx7-sdb boards.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6302dbc..8ec4dbb 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -262,6 +262,7 @@ CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_SND_SOC_FSL_ASOC_CARD=y
 CONFIG_SND_SOC_CS42XX8_I2C=y
 CONFIG_SND_SOC_TLV320AIC3X=y
+CONFIG_SND_SOC_WM8960=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.9.1
