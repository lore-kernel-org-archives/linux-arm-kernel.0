From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:51 +0800
Subject: [PATCH V6 8/9] ARM: tegra: config: defconfig update
In-Reply-To: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
References: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364988712-24797-9-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KEYBOARD_GPIO:
* Enable gpio-key driver

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V6:
* no change
V5:
* no change
V4:
* no change
V3:
* no change
V2:
* no change
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 2b42a2c..a5f0485 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -106,6 +106,7 @@ CONFIG_RT2X00=y
 CONFIG_RT2800USB=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_TEGRA=y
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
 # CONFIG_LEGACY_PTYS is not set
-- 
1.8.2
