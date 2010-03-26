From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 26 Mar 2010 06:51:32 +0100
Subject: [PATCH] Update MAINTAINERS entries
Message-ID: <1269582692-5594-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New MAINTAINERS entries for Zipit Z2 and Voipac PXA270

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 MAINTAINERS |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 449d444..518152d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -984,6 +984,20 @@ W:	http://www.arm.linux.org.uk/
 S:	Maintained
 F:	arch/arm/vfp/
 
+ARM/VOIPAC PXA270 SUPPORT
+M:	Marek Vasut <marek.vasut@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-pxa/vpac270.c
+F:	arch/arm/mach-pxa/include/mach-pxa/vpac270.h
+
+ARM/ZIPIT Z2 SUPPORT
+M:	Marek Vasut <marek.vasut@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-pxa/z2.c
+F:	arch/arm/mach-pxa/include/mach-pxa/z2.h
+
 ASC7621 HARDWARE MONITOR DRIVER
 M:	George Joseph <george.joseph@fairview5.com>
 L:	lm-sensors at lm-sensors.org
-- 
1.7.0
