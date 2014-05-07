From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 7 May 2014 12:18:02 +0900
Subject: [PATCH] ARM: tegra: enable console framebuffer rotation
Message-ID: <1399432682-677-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Console rotation is needed for devices like Tegra Note 7 and NVIDIA
SHIELD to get the boot console in the expected orientation.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index c706d399557b..e2441e286822 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -183,6 +183,7 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-- 
1.9.2
