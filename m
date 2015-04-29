From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Apr 2015 11:11:41 -0300
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Enable RTC PCF8523 support
Message-ID: <1430316701-5912-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

RTC PCF8523 is used on some mx6 cubox-i boards.

Let it work by default.

Reported-by: Rick Thomas <rbthomas@cube.rcthomas.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None, just re-send it without being part of a patch series

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index fdeb1c8..1d93fe9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -283,6 +283,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_ISL1208=y
+CONFIG_RTC_DRV_PCF8523=y
 CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
-- 
1.9.1
