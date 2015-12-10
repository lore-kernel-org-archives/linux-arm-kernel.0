From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 10 Dec 2015 16:16:00 +0100
Subject: [PATCH 1/3] ARM: shmobile: defconfig: Drop useless
 CONFIG_USB_RCAR_PHY=y
In-Reply-To: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
References: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449760562-26795-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Renesas R-Car (Gen1) USB PHY driver (which is being removed) does
not support DT, and is thus useless in a Renesas ARM multi-platform
kernel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 70d718e088a65fed..9a30c2c464c946ca 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -162,7 +162,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
-CONFIG_USB_RCAR_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
 CONFIG_USB_ETH=y
-- 
1.9.1
