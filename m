From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 26 Aug 2014 17:28:57 +0200
Subject: [PATCH v2 3/3] ARM: multi_v7_defconfig: Enable Atmel maXTouch support
In-Reply-To: <1409066937-3574-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1409066937-3574-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1409066937-3574-4-git-send-email-javier.martinez@collabora.co.uk>
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
index 5fb95fb..d139a8d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -164,6 +164,7 @@ CONFIG_KEYBOARD_ST_KEYSCAN=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
-- 
2.0.1
