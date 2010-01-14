From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:39 +0100
Subject: [PATCH 21/21] MAINTAINERS: add ARM/S5PC100 and ARM/S5PC110
	architectures
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-22-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Add entries for the ARM S5PC100 and ARM S5PC110 architectures that are
currently being maintained by ourself.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 MAINTAINERS |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8f47bf..d5fe79c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -936,6 +936,22 @@ W:	http://www.fluff.org/ben/linux/
 S:	Maintained
 F:	arch/arm/mach-s3c6410/
 
+ARM/S5PC100 ARM ARCHITECTURE
+M:	Kyungmin Park <kyungmin.park@samsung.com>
+M:	Marek Szyprowski <m.szyprowski@samsung.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm/mach-s5pc100/
+
+ARM/S5PC110 ARM ARCHITECTURE
+M:	Kyungmin Park <kyungmin.park@samsung.com>
+M:	Marek Szyprowski <m.szyprowski@samsung.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm/mach-s5pc110/
+
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.6.4
