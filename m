From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 14 Jun 2011 09:44:29 +0400
Subject: [PATCH] sa1100: move serial_sa1100.h header to
	arch/arm/mach-sa1100/include/mach
Message-ID: <1308030269-32629-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/assabet.c                     |    2 +-
 arch/arm/mach-sa1100/badge4.c                      |    2 +-
 arch/arm/mach-sa1100/cerf.c                        |    2 +-
 arch/arm/mach-sa1100/collie.c                      |    2 +-
 arch/arm/mach-sa1100/h3xxx.c                       |    2 +-
 arch/arm/mach-sa1100/hackkit.c                     |    2 +-
 .../include}/mach/serial_sa1100.h                  |    0
 arch/arm/mach-sa1100/jornada720.c                  |    2 +-
 arch/arm/mach-sa1100/lart.c                        |    2 +-
 arch/arm/mach-sa1100/nanoengine.c                  |    2 +-
 arch/arm/mach-sa1100/neponset.c                    |    2 +-
 arch/arm/mach-sa1100/pleb.c                        |    2 +-
 arch/arm/mach-sa1100/shannon.c                     |    2 +-
 arch/arm/mach-sa1100/simpad.c                      |    2 +-
 drivers/tty/serial/sa1100.c                        |    2 +-
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/{include/asm => mach-sa1100/include}/mach/serial_sa1100.h (100%)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 5778274..56779ce 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -33,7 +33,7 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/irda.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 #include <mach/assabet.h>
 #include <mach/mcp.h>
 
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 4f19ff8..2a586df 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -32,7 +32,7 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/sa1111.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 
 #include <mach/badge4.h>
 
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 7f3da4b..084c8b1 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -26,7 +26,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 
 #include <mach/cerf.h>
 #include <mach/mcp.h>
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index bd3e1bf..f614a59 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -37,7 +37,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index b0784c9..368af40 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -22,7 +22,7 @@
 
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 
 #include <mach/h3xxx.h>
 
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index db5e434..d270d87 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -33,7 +33,7 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/include/asm/mach/serial_sa1100.h b/arch/arm/mach-sa1100/include/mach/serial_sa1100.h
similarity index 100%
rename from arch/arm/include/asm/mach/serial_sa1100.h
rename to arch/arm/mach-sa1100/include/mach/serial_sa1100.h
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 491ac9f..fffa6d1 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -31,7 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 7b9556b..e398b5c 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -13,7 +13,7 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 #include <mach/mcp.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 72087f0..c743ca7 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -23,7 +23,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 
 #include <mach/hardware.h>
 #include <mach/nanoengine.h>
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index b4fa53a..552a845 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -14,7 +14,7 @@
 #include <asm/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 #include <mach/assabet.h>
 #include <mach/neponset.h>
 #include <asm/hardware/sa1111.h>
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 65161f2..f9809a8 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -18,7 +18,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 #include <mach/irqs.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 7917b24..5148ca3 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -16,7 +16,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 #include <mach/mcp.h>
 #include <mach/shannon.h>
 
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index cfb7607..dd1942c 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -22,7 +22,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 #include <mach/mcp.h>
 #include <mach/simpad.h>
 
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index ef7a21a..0426ee0 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -38,7 +38,7 @@
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
-#include <asm/mach/serial_sa1100.h>
+#include <mach/serial_sa1100.h>
 
 /* We've been assigned a range on the "Low-density serial ports" major */
 #define SERIAL_SA1100_MAJOR	204
-- 
1.7.5.3
