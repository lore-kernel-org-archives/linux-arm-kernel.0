From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 23:18:54 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: eanble anatop regulator and snvs rtc
Message-ID: <1359472734-30426-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eanble anatop regulator and snvs rtc support which are very useful
for imx6q build.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6966713..1d9b9fc6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -151,6 +151,7 @@ CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_DA9052=y
+CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_MEDIA_SUPPORT=y
@@ -197,6 +198,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
+CONFIG_RTC_DRV_SNVS=y
 CONFIG_DMADEVICES=y
 CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
-- 
1.7.9.5
