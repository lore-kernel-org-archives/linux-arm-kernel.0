From: scott.branden@broadcom.com (Scott Branden)
Date: Sat,  8 Oct 2016 13:41:04 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Intel e1000e driver
Message-ID: <1475959264-16582-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the Intel e1000e driver

Signed-off-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ea3566f..b88a67a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -843,6 +843,7 @@ CONFIG_PWM_SUN4I=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
 CONFIG_PHY_HIX5HD2_SATA=y
+CONFIG_E1000E=y
 CONFIG_PWM_STI=y
 CONFIG_PWM_BCM2835=y
 CONFIG_PWM_BRCMSTB=m
-- 
2.5.0
