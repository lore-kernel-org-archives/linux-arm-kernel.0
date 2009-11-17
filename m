From: h.feurstein@gmail.com (Hubert Feurstein)
Date: Tue, 17 Nov 2009 12:45:56 +0100
Subject: [PATCH] ep93xx: add missing newline between file header and code
Message-ID: <200911171245.56363.h.feurstein@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
---
 Just for the sake of consistency across the ep93xx-tree.

 arch/arm/mach-ep93xx/include/mach/hardware.h |    1 +
 arch/arm/mach-ep93xx/include/mach/io.h       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/hardware.h b/arch/arm/mach-ep93xx/include/mach/hardware.h
index 349fa7c..5a3ce02 100644
--- a/arch/arm/mach-ep93xx/include/mach/hardware.h
+++ b/arch/arm/mach-ep93xx/include/mach/hardware.h
@@ -1,6 +1,7 @@
 /*
  * arch/arm/mach-ep93xx/include/mach/hardware.h
  */
+
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
 
diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
index cebcc1c..594b77f 100644
--- a/arch/arm/mach-ep93xx/include/mach/io.h
+++ b/arch/arm/mach-ep93xx/include/mach/io.h
@@ -1,6 +1,7 @@
 /*
  * arch/arm/mach-ep93xx/include/mach/io.h
  */
+
 #ifndef __ASM_MACH_IO_H
 #define __ASM_MACH_IO_H
 
-- 
1.6.4.4
