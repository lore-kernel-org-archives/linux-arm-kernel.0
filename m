From: chanho.min@lge.com (Chanho Min)
Date: Mon, 11 Apr 2016 20:54:47 +0900
Subject: [PATCH v3 4/4] MAINTAINERS: add myself as ARM/LG1K maintainer
In-Reply-To: <1460375687-2375-1-git-send-email-chanho.min@lge.com>
References: <1460375687-2375-1-git-send-email-chanho.min@lge.com>
Message-ID: <1460375687-2375-5-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f55edf..20ca61a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1245,6 +1245,12 @@ L:	linux-kernel at vger.kernel.org
 S:	Maintained
 F:	drivers/memory/*emif*
 
+ARM/LG1K ARCHITECTURE
+M:	Chanho Min <chanho.min@lge.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/lg/
+
 ARM/LOGICPD PXA270 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.9.5
