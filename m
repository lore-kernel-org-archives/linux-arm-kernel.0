From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sun, 26 Feb 2012 12:40:19 +0100
Subject: [PATCH] MAINTAINERS: update maintainer entry for pxa/hx4700
Message-ID: <1330256419.3673.27.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Paul Parsons as maintainer for pxa/hx4700.
Also, add a mailing list and update the files.

Cc: Paul Parsons <lost.distance@yahoo.com>
Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 MAINTAINERS |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a648eb..154ab2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -815,9 +815,12 @@ S:	Maintained
 
 ARM/H4700 (HP IPAQ HX4700) MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
+M:	Paul Parsons <lost.distance@yahoo.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/hx4700.c
 F:	arch/arm/mach-pxa/include/mach/hx4700.h
+F:	sound/soc/pxa/hx4700.c
 
 ARM/HP JORNADA 7XX MACHINE SUPPORT
 M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
-- 
1.7.9
