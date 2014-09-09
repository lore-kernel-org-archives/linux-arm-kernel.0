From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  9 Sep 2014 10:00:18 +0100
Subject: [PATCH v2 4/4] ARM: multi_v7_defconfig: Enable stih407 usb picophy
In-Reply-To: <1410253218-18318-1-git-send-email-peter.griffin@linaro.org>
References: <1410253218-18318-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1410253218-18318-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the picoPHY usb phy which is used by
the usb2 and usb3 host controllers when controlling usb2/1.1
devices. It is found in stih407 family SoC's from STMicroelectronics.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fb95fb..65f4611 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -387,6 +387,7 @@ CONFIG_PWM_VT8500=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY365X=y
+CONFIG_PHY_STIH407_USB=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
-- 
1.9.1
