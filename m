From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Wed, 29 Apr 2015 16:40:27 -0500
Subject: [PATCH 1/1] ARM: imx: Correct the comments in time.c
Message-ID: <1430343627-60688-1-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comments were corrected as the following to reflect
the real situation of Freescale MXC timer IP block.
There are totally 4 version of the timer on Freescale i.MX SoCs.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index acb1ff5..b1698e1 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -38,9 +38,11 @@
 #include "hardware.h"
 
 /*
- * There are 2 versions of the timer hardware on Freescale MXC hardware.
- * Version 1: MX1/MXL, MX21, MX27.
- * Version 2: MX25, MX31, MX35, MX37, MX51
+ * There are 4 versions of the timer hardware on Freescale MXC hardware.
+ * Version 0: MX1/MXL
+ * Version 1: MX21, MX27.
+ * Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q(rev1.0)
+ * Version 3: MX6DL, MX6SX, MX6Q(rev1.1+)
  */
 
 /* defines common for all i.MX */
-- 
1.9.1
