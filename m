From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Jul 2014 22:32:51 +0200
Subject: [PATCH] MAINTAINERS: Remove Kirkwood
Message-ID: <1405542771-22258-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-kirkwood has been removed, since kirkwood is now
supported by arch/arm/mach-mvebu. Remove it from the MAINTAINERS file.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 134483f206e4..77cbbff00663 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1079,14 +1079,13 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-berlin/
 
-ARM/Marvell Dove/Kirkwood/MV78xx0/Orion SOC support
+ARM/Marvell Dove/MV78xx0/Orion SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-dove/
-F:	arch/arm/mach-kirkwood/
 F:	arch/arm/mach-mv78xx0/
 F:	arch/arm/mach-orion5x/
 F:	arch/arm/plat-orion/
-- 
2.0.1
