From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 27 Aug 2014 16:24:47 +0200
Subject: [PATCH v3 3/3] ARM: multi_v7_defconfig: Enable Atmel maXTouch support
In-Reply-To: <1409149487-23582-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1409149487-23582-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1409149487-23582-4-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards with multi platform support (e.g: Exynos based
Chromebooks) have an Atmel trackpad so enable support for
as a module will make easier for users.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7cfa5fa..ac5c10c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -167,6 +167,7 @@ CONFIG_KEYBOARD_ST_KEYSCAN=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
-- 
2.0.1
