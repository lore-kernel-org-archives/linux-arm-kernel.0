From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:37 +0200
Subject: [PATCH 02/16] arm/mx25: rename mach-mx25pdk.c to mach-mx25_3ds.c
	matching its arch number
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additionally document all known names of that machine.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Makefile                        |    2 +-
 .../mach-mx25/{mach-mx25pdk.c => mach-mx25_3ds.c}  |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)
 rename arch/arm/mach-mx25/{mach-mx25pdk.c => mach-mx25_3ds.c} (97%)

diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
index 10cebc5..6db9603 100644
--- a/arch/arm/mach-mx25/Makefile
+++ b/arch/arm/mach-mx25/Makefile
@@ -1,3 +1,3 @@
 obj-y				:= mm.o devices.o
 obj-$(CONFIG_ARCH_MX25)		+= clock.o
-obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25pdk.o
+obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25_3ds.o
diff --git a/arch/arm/mach-mx25/mach-mx25pdk.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
similarity index 97%
rename from arch/arm/mach-mx25/mach-mx25pdk.c
rename to arch/arm/mach-mx25/mach-mx25_3ds.c
index 83d7410..26ba246 100644
--- a/arch/arm/mach-mx25/mach-mx25pdk.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -16,6 +16,12 @@
  * Boston, MA  02110-1301, USA.
  */
 
+/*
+ * This machine is known as:
+ *  - i.MX25 3-Stack Development System
+ *  - i.MX25 Platform Development Kit (i.MX25 PDK)
+ */
+
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
1.7.0
