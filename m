From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 25 Jun 2012 12:21:10 +0200
Subject: ARM: BAST: update MAINTAINERS entry
Message-ID: <1340619670.1773.162.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 85fd6d63bf2927b9da7ab1b0d46723bfdb13808c ("ARM: S3C2410: move
mach-s3c2410/* into mach-s3c24xx/") moved the three files mentioned in
the "SIMTEC EB2410ITX (BAST)" MAINTAINERS entry to the arch/arm/s3c24xx
directory. Update that entry accordingly.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 MAINTAINERS |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb22272..df09359 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6145,9 +6145,9 @@ P:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 W:	http://www.simtec.co.uk/products/EB2410ITX/
 S:	Supported
-F:	arch/arm/mach-s3c2410/mach-bast.c
-F:	arch/arm/mach-s3c2410/bast-ide.c
-F:	arch/arm/mach-s3c2410/bast-irq.c
+F:	arch/arm/mach-s3c24xx/mach-bast.c
+F:	arch/arm/mach-s3c24xx/bast-ide.c
+F:	arch/arm/mach-s3c24xx/bast-irq.c
 
 TI DAVINCI MACHINE SUPPORT
 M:	Sekhar Nori <nsekhar@ti.com>
-- 
1.7.7.6
