From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Wed, 29 Aug 2018 17:17:44 +0300
Subject: [PATCH v2 2/2] ARM: multi_v7_defconfig: add generic resistive
 touchscreen
In-Reply-To: <1535552264-8923-1-git-send-email-eugen.hristev@microchip.com>
References: <1535552264-8923-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1535552264-8923-2-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add generic resistive touchscreen CONFIG_TOUCHSCREEN_ADC

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
- split config change into two commits, per defconfig

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc33444..a1b2cfa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -282,6 +282,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADC=m
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_MMS114=m
 CONFIG_TOUCHSCREEN_WM97XX=m
-- 
2.7.4
