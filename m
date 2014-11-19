From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 19 Nov 2014 08:27:11 +0000
Subject: [PATCH 6/7] ARM: multi_v7_defconfig: Enable stih407 usb picophy
In-Reply-To: <1416385632-5832-1-git-send-email-peter.griffin@linaro.org>
References: <1416385632-5832-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1416385632-5832-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the picoPHY usb phy which is used by
the usb2 and usb3 host controllers when controlling usb2/1.1
devices. It is found in stih407 family SoC's from STMicroelectronics.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e13ab7e..ac7b536 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -427,6 +427,7 @@ CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_STIH41X_USB=y
+CONFIG_PHY_STIH407_USB=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
-- 
1.9.1
