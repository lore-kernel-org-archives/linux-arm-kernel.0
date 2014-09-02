From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  2 Sep 2014 09:57:10 -0600
Subject: [PATCH 2/2] ARM: tegra: enable Atmel touchpad in defconfig
In-Reply-To: <1409673430-7039-1-git-send-email-swarren@wwwdotorg.org>
References: <1409673430-7039-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1409673430-7039-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This driver is used on Venice2 for the touchpad.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index e5b5f3122fe6..62a0ee9973e3 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -121,6 +121,7 @@ CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
-- 
1.9.1
