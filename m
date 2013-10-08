From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  8 Oct 2013 14:24:27 +0200
Subject: [PATCH 2/8] MAINTAINERS: add ARM Marvell Berlin SoC
In-Reply-To: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1381235073-17134-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds Marvell Berlin SoC to the list of maintainers. I am taking
maintainership for arch/arm/mach-berlin/.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a0cbf3..7964fe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1013,6 +1013,12 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-mvebu/
 
+ARM/Marvell Berlin SoC support
+M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-berlin/
+
 ARM/Marvell Dove/Kirkwood/MV78xx0/Orion SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
-- 
1.7.10.4
