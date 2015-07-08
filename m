From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed,  8 Jul 2015 15:40:46 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Remove old Samsung USB PHY configs
Message-ID: <1436395246-17540-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old drivers/usb/phy/phy-samsung-usb{2,3} are now deleted since
were replaced by newers drivers that use the Generic PHY framework
but their Kconfig options were left over in multi_v7_defconfig.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/configs/multi_v7_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 77f4b76d16e9..e3fdc3dd02f6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -493,8 +493,6 @@ CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_OMAP_USB3=y
-CONFIG_SAMSUNG_USB2PHY=y
-CONFIG_SAMSUNG_USB3PHY=y
 CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MXS_PHY=y
-- 
2.4.3
