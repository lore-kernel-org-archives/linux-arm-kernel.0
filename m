From: T.Mehnert@eckelmann.de (Mehnert, Torsten)
Date: Tue, 28 Feb 2012 17:48:02 +0000
Subject: [PATCH 1/2] mxc_ehci.h: add flags for usb hwinit
Message-ID: <3F263ABB4EDE344D974E1983B56807739E4BC6B3@EX-DAG02.eckelmann.group>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: T. Mehnert <t.mehnert@eckelmann.de>
Date: Thu, 16 Feb 2012 14:10:20 +0100
Subject: [PATCH] mxc_ehci.h extending flags for hwinit

This Patch adds defines for the flags field. This flags
are used for usb hw initialisation. The new flags will give
more options to configure the usb hardware from the board
file.
---
 arch/arm/plat-mxc/include/mach/mxc_ehci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc_ehci.h b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
index 2c159dc..5edbb95 100644
--- a/arch/arm/plat-mxc/include/mach/mxc_ehci.h
+++ b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
@@ -27,6 +27,9 @@
 #define MXC_EHCI_IPPUE_UP		(1 << 9)
 #define MXC_EHCI_WAKEUP_ENABLED	(1 << 10)
 #define MXC_EHCI_ITC_NO_THRESHOLD	(1 << 11)
+#define MXC_EHCI_AHB_LOCK_ENABLE	(1 << 12)
+#define MXC_EHCI_POWER_POLARITY_HIGH	(1 << 13)
+#define MXC_EHCI_XCVR_FORCED_INTERNAL	(1 << 14)
 
 #define MXC_USBCTRL_OFFSET		0
 #define MXC_USB_PHY_CTR_FUNC_OFFSET	0x8
-- 
1.7.0.4
---
Torsten Mehnert
K?lte- und Geb?udeleittechnik (KGL)
?
ECKELMANN AG
Berliner Stra?e 161
D - 65205 Wiesbaden
?
Phone:	+49 (0) 611 / 7103 - 370
Fax:	+49 (0) 611 / 7103 - 133

e-Mail:	mailto:t.mehnert@eckelmann.de
Web:	http://www.eckelmann.de
