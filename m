From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  8 Dec 2013 15:13:59 +0100
Subject: [PATCH v4 2/9] MAINTAINERS: add ARM Marvell Berlin SoC
In-Reply-To: <1386512047-874-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386512047-874-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1386512047-874-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds Marvell Berlin SoC to the list of maintainers. I am taking
maintainership for arch/arm/mach-berlin/.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
Changelog:
any->v4:
- none

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8285ed4..33c7187 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1032,6 +1032,12 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
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
1.8.4.rc3
