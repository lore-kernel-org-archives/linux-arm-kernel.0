From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 13:31:31 +0200
Subject: [PATCH v4 3/3] ARM: exynos_defconfig: Enable Atmel maXTouch support
In-Reply-To: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410348691-18317-4-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Exynos based Chromebooks have an Atmel trackpad so enable
support for it by default will make easier for users.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v3: None

 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index fbbac06..f00d0fc 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -60,6 +60,7 @@ CONFIG_KEYBOARD_CROS_EC=y
 # CONFIG_MOUSE_PS2 is not set
 CONFIG_MOUSE_CYAPA=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
-- 
2.1.0
