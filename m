From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:12 +0900
Subject: [PATCH 7/7] ARM: shmobile: Enable USB [EO]HCI HCD support in
 shmobile_defconfig
In-Reply-To: <cover.1397627278.git.horms+renesas@verge.net.au>
References: <cover.1397627278.git.horms+renesas@verge.net.au>
Message-ID: <1d59eb190e3dc575c7bbee4a163c3facd0de2ed9.1397627278.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB [EO]HCI HCD drivers provide USB host support for Renesas
R-Car Gen2 platforms. To increase hardware support enable the driver in the
shmobile_defconfig multiplatform configuration.

Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 8fb30b0..6d6437c 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -110,6 +110,8 @@ CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RCAR=y
 CONFIG_USB=y
 CONFIG_USB_RCAR_GEN2_PHY=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
-- 
1.8.5.2
