From: carlo@caione.org (Carlo Caione)
Date: Thu, 27 Mar 2014 22:29:24 +0100
Subject: [PATCH v3 10/10] ARM: sunxi: Add AXP20x support multi_v7_defconfig
In-Reply-To: <1395955764-18103-1-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
Message-ID: <1395955764-18103-11-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ee69829..239c014 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -134,6 +134,7 @@ CONFIG_KEYBOARD_SPEAR=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_INPUT_MPU3050=y
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
@@ -189,6 +190,7 @@ CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MFD_AS3722=y
+CONFIG_MFD_AXP20X=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_MFD_MAX8907=y
@@ -199,6 +201,7 @@ CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_AS3722=y
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_PALMAS=y
-- 
1.8.3.2
