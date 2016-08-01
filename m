From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue,  2 Aug 2016 00:34:48 +0800
Subject: [PATCH v2 3/3] ehci-platform: add the max clock number to 4
In-Reply-To: <20160801163448.54921-1-icenowy@aosc.xyz>
References: <20160801163448.54921-1-icenowy@aosc.xyz>
Message-ID: <20160801163448.54921-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 EHCI requires 4 clocks to be enabled.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/usb/host/ehci-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 6816b8c..876dca4 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -38,7 +38,7 @@
 #include "ehci.h"
 
 #define DRIVER_DESC "EHCI generic platform driver"
-#define EHCI_MAX_CLKS 3
+#define EHCI_MAX_CLKS 4
 #define EHCI_MAX_RSTS 3
 #define hcd_to_ehci_priv(h) ((struct ehci_platform_priv *)hcd_to_ehci(h)->priv)
 
-- 
2.9.0
