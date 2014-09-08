From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  8 Sep 2014 11:33:03 +0100
Subject: [PATCH v4 4/4] ARM: multi_v7_defconfig: Enable stih41x usb phy driver.
In-Reply-To: <1410172383-17306-1-git-send-email-peter.griffin@linaro.org>
References: <1410172383-17306-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1410172383-17306-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is used by the ehci / ohci usb controllers on stih41x SoCs.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fb95fb..74fd4a1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -387,6 +387,7 @@ CONFIG_PWM_VT8500=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY365X=y
+CONFIG_PHY_STIH41X_USB=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
-- 
1.9.1
