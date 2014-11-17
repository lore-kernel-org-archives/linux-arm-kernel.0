From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 17 Nov 2014 16:47:58 +0000
Subject: [PATCH v3 05/11] ARM: multi_v7_defconfig: Enable stih415/6 usb2 phy
 driver.
In-Reply-To: <1416242884-5261-1-git-send-email-peter.griffin@linaro.org>
References: <1416242884-5261-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1416242884-5261-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is used by the ehci / ohci usb controllers on stih415/6 SoCs.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c7a9517..e13ab7e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -426,6 +426,7 @@ CONFIG_PWM_VT8500=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY365X=y
+CONFIG_PHY_STIH41X_USB=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
-- 
1.9.1
