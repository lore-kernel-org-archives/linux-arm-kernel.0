From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 22 Nov 2013 14:56:04 -0800
Subject: [PATCH v5 2/2] ARM: bcm281xx: watchdog configuration
In-Reply-To: <1385160964-18578-1-git-send-email-markus.mayer@linaro.org>
References: <1385160964-18578-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1385160964-18578-3-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the watchdog driver for the BCM281xx family of SoCs.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/configs/bcm_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 287ac1d..d4d0083 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -126,3 +126,6 @@ CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_XZ_DEC=y
 CONFIG_AVERAGE=y
+CONFIG_WATCHDOG=y
+CONFIG_BCM_KONA_WDT=y
+CONFIG_BCM_KONA_WDT_DEBUG=y
-- 
1.7.9.5
