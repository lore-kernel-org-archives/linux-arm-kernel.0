From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Feb 2016 16:23:04 +0100
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Enable XHCI_RCAR
In-Reply-To: <cover.1454409855.git.horms+renesas@verge.net.au>
References: <cover.1454409855.git.horms+renesas@verge.net.au>
Message-ID: <20cc7dd4d03d912d28a642701f08c7dba8622436.1454409855.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used by Renesas R-Car SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 314f6be2dca2..69d6a6d358cb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -577,6 +577,7 @@ CONFIG_SND_SOC_WM8978=m
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
+CONFIG_USB_XHCI_RCAR=m
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MSM=m
 CONFIG_USB_EHCI_EXYNOS=y
-- 
2.7.0.rc3.207.g0ac5344
