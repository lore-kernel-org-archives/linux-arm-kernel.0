From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Nov 2016 22:04:35 +0100
Subject: [PATCH] MAINTAINERS: Add device tree bindings to mv88e6xx section
Message-ID: <1480280676-10117-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also include the netdev list for convenience, as done elsewhere.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f73e19277a70..46ccf6eadcc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7670,6 +7670,7 @@ M:	Andrew Lunn <andrew@lunn.ch>
 M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
 S:	Maintained
 F:	drivers/net/dsa/mv88e6xxx/
+F:	Documentation/devicetree/bindings/net/dsa/marvell.txt
 
 MARVELL ARMADA DRM SUPPORT
 M:	Russell King <rmk+kernel@armlinux.org.uk>
-- 
2.6.6
