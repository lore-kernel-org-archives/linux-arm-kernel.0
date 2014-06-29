From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 Jun 2014 20:23:57 +0200
Subject: [PATCH v7 6/6] ARM: sunxi: Add AXP20x support multi_v7_defconfig
In-Reply-To: <1404066237-20234-1-git-send-email-carlo@caione.org>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
Message-ID: <1404066237-20234-7-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index be1a345..d79418e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -159,6 +159,7 @@ CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -229,6 +230,7 @@ CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AS3722=y
+CONFIG_MFD_AXP20X=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_MFD_MAX8907=y
@@ -240,6 +242,7 @@ CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_AS3722=y
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_PALMAS=y
-- 
1.9.1
