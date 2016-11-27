From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Nov 2016 22:07:30 +0100
Subject: [PATCH v2] MAINTAINERS: Add device tree bindings to mv88e6xx section
In-Reply-To: <1480280676-10117-1-git-send-email-afaerber@suse.de>
References: <1480280676-10117-1-git-send-email-afaerber@suse.de>
Message-ID: <1480280850-10409-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also include the netdev list for convenience, as done elsewhere.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f73e19277a70..677d73cfedc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7668,8 +7668,10 @@ S:	Maintained
 MARVELL 88E6XXX ETHERNET SWITCH FABRIC DRIVER
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
+L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/dsa/mv88e6xxx/
+F:	Documentation/devicetree/bindings/net/dsa/marvell.txt
 
 MARVELL ARMADA DRM SUPPORT
 M:	Russell King <rmk+kernel@armlinux.org.uk>
-- 
2.6.6
