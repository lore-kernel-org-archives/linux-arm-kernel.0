From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 14 May 2014 11:09:13 +0900
Subject: [PATCH v2] ARM: tegra: enable joystick in tegra_defconfig
Message-ID: <1400033353-25673-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA SHIELD embeds a USB joystick device. Enable the corresponding
support in tegra_defconfig.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes since v1:
- Have support built-in instead of as a module
- Fixed wording in commit message

 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8c1625b78034..1faa68f8988b 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -114,6 +114,7 @@ CONFIG_USB_NET_SMSC95XX=y
 CONFIG_BRCMFMAC=m
 CONFIG_RT2X00=y
 CONFIG_RT2800USB=m
+CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_TEGRA=y
-- 
1.9.2
