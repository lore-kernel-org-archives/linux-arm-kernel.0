From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 4 Mar 2013 19:41:44 +0800
Subject: [PATCH 10/10] ARM: tegra: config: defconfig update
Message-ID: <1362397304-6200-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KEYBOARD_GPIO:
* Enable gpio-key driver

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index aba4881..6eee91d 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -108,6 +108,7 @@ CONFIG_RT2X00=y
 CONFIG_RT2800USB=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_TEGRA=y
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
 # CONFIG_LEGACY_PTYS is not set
-- 
1.8.1.1
