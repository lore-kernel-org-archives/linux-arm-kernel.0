From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 27 Jun 2014 15:34:21 +0200
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: add ST Keyscan driver
Message-ID: <1403876061-8519-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds KEYBOARD_ST_KEYSCAN config

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 19dbddb..c123e35 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -155,6 +155,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_SPEAR=y
+CONFIG_KEYBOARD_ST_KEYSCAN=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_MISC=y
-- 
1.9.1
