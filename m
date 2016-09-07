From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:41:27 +0200
Subject: [PATCH 1/2] arm64: defconfig: Add Renesas R-Car HSUSB driver support
 as module
In-Reply-To: <cover.1473233745.git.horms+renesas@verge.net.au>
References: <cover.1473233745.git.horms+renesas@verge.net.au>
Message-ID: <94106a8dbaf56b50ba35faa32baae4ad8dcf17ed.1473233745.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0555b7caaf2c..458d891aaa8e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -265,6 +265,7 @@ CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_EXYNOS=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
@@ -276,6 +277,7 @@ CONFIG_USB_HSIC_USB3503=y
 CONFIG_USB_MSM_OTG=y
 CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
+CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
-- 
2.7.0.rc3.207.g0ac5344
