From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon,  8 Oct 2012 10:47:34 +0200
Subject: [PATCH 1/1] ARM: OMAP: Add maintainer entry for IGEP machines
Message-ID: <1349686054-7486-1-git-send-email-javier@dowhile0.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enric and I have been mantained this machine and while we
are moving to device trees, it is good that people cc us
when reporting bugs or regression on the board file until
we have proper DT support.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63ce2a2..6b3c58d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -818,6 +818,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
 F:	arch/arm/mach-sa1100/jornada720.c
 F:	arch/arm/mach-sa1100/include/mach/jornada720.h
 
+ARM/IGEP MACHINE SUPPORT
+M:	Enric Balletbo i Serra <eballetbo@gmail.com>
+M:	Javier Martinez Canillas <javier@dowhile0.org>
+L:	linux-omap at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-omap2/board-igep0020.c
+
 ARM/INCOME PXA270 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.7.6
