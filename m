From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Thu, 15 Oct 2009 16:39:30 +0100
Subject: [PATCH] MAINTAINERS: Add entries for IMote 2 and Stargate 2
Message-ID: <4AD74232.2030007@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
Have finally remembered to do this.

 MAINTAINERS |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5eb8c1..48282d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -699,6 +699,19 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-ixp4xx/
 
+ARM/INTEL RESEARCH IMOTE 2 MACHINE SUPPORT
+M:	Jonathan Cameron <jic23@cam.ac.uk>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-pxa/imote2.c
+
+ARM/INTEL RESEARCH STARGATE 2 MACHINE SUPPORT
+M:	Jonathan Cameron <jic23@cam.ac.uk>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-pxa/stargate2.c
+F:	drivers/pcmcia/pxa2xx_stargate2.c
+
 ARM/INTEL XSC3 (MANZANO) ARM CORE
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 M:	Dan Williams <dan.j.williams@intel.com>
-- 
1.6.3.3
