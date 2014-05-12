From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 12 May 2014 17:26:48 +0900
Subject: [PATCH 1/2] ARM: tegra: joystick input in tegra_defconfig
In-Reply-To: <1399883209-31169-1-git-send-email-acourbot@nvidia.com>
References: <1399883209-31169-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1399883209-31169-2-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA SHIELD embeds a USB controller. Compile the corresponding support
as a module in tegra_defconfig.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8c1625b78034..f99121b78968 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -114,6 +114,7 @@ CONFIG_USB_NET_SMSC95XX=y
 CONFIG_BRCMFMAC=m
 CONFIG_RT2X00=y
 CONFIG_RT2800USB=m
+CONFIG_INPUT_JOYDEV=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_TEGRA=y
-- 
1.9.2
