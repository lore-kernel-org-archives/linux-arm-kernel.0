From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 11 Dec 2015 11:45:25 +0100
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: Drop useless
 CONFIG_USB_RCAR_PHY=y
In-Reply-To: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
References: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449830727-325-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Renesas R-Car (Gen1) USB PHY driver (which is being removed) does
not support DT, and is thus useless in a generic ARM multi-platform
kernel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2735bc73b2854882..e0fb5f34c0aca450 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -545,7 +545,6 @@ CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MSM_OTG=m
 CONFIG_USB_MXS_PHY=y
-CONFIG_USB_RCAR_PHY=m
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_USB_ETH=m
-- 
1.9.1
