From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Jan 2016 13:00:00 +0900
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable XHCI_RCAR
In-Reply-To: <1452484800-7470-1-git-send-email-horms+renesas@verge.net.au>
References: <1452484800-7470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1452484800-7470-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used by Renesas R-Car SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 653d3c6ac525..33f96b587a8e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -526,6 +526,7 @@ CONFIG_SND_SOC_WM8978=m
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
+CONFIG_USB_XHCI_RCAR=m
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MSM=m
 CONFIG_USB_EHCI_EXYNOS=y
-- 
2.7.0.rc3.207.g0ac5344
