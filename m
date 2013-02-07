From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Thu,  7 Feb 2013 23:03:58 +0530
Subject: [PATCH 01/10] USB:Changed omap2plus_defconfig to support OMAP USB
 static driver
In-Reply-To: <1360258447-27247-1-git-send-email-yes>
References: <yes>
 <1360258447-27247-1-git-send-email-yes>
Message-ID: <5113e5cb.c84e420a.08c3.ffffbe4f@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Selected EHCI and OMAP driver as static drivers using omap2plus_defconfig
configuration

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 82ce8d7..9ea7a9c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -182,6 +182,10 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+CONFIG_USB_EHCI_HCD_OMAP=y
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_LIBUSUAL=y
-- 
1.7.9.5
