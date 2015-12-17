From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Dec 2015 14:24:52 +0900
Subject: [PATCH 2/7] ARM: shmobile: defconfig: Drop useless
 CONFIG_USB_RCAR_PHY=y
In-Reply-To: <cover.1450315426.git.horms+renesas@verge.net.au>
References: <cover.1450315426.git.horms+renesas@verge.net.au>
Message-ID: <59ab5e08b2a60f97e3b59eb8fa4a79c567fc98a5.1450315426.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Renesas R-Car (Gen1) USB PHY driver (which is being removed) does
not support DT, and is thus useless in a Renesas ARM multi-platform
kernel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index e51f7a79c730..91233ed27578 100644
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
2.1.4
