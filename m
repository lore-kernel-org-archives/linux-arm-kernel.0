From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 May 2014 22:08:04 -0500
Subject: [PATCH 6/6] ARM: multi_v7: Add Allwinner reset drivers to
 multi_v7_defconfig
In-Reply-To: <1399259284-6282-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399259284-6282-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399259284-6282-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the reset code are part of drivers of their own, we need those in the
defconfig.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47a2f7c..960187ac35e0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -200,12 +200,14 @@ CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
+CONFIG_POWER_RESET_SUN6I=y
 CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_DOVE_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
-- 
1.9.1
