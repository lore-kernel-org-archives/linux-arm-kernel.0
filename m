From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:36 +0200
Subject: [PATCH 01/16] arm/mx3: rename mach-mx35pdk.c to mach-mx35_3ds.c
	matching its arch number
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additional document all known names of that machine.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Makefile                         |    2 +-
 .../mach-mx3/{mach-mx35pdk.c => mach-mx35_3ds.c}   |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)
 rename arch/arm/mach-mx3/{mach-mx35pdk.c => mach-mx35_3ds.c} (96%)

diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 5d650fd..2a4798d 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -22,5 +22,5 @@ obj-$(CONFIG_MACH_MX31MOBOARD)	+= mach-mx31moboard.o mx31moboard-devboard.o \
 obj-$(CONFIG_MACH_QONG)		+= mach-qong.o
 obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
-obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35pdk.o
+obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
 obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
diff --git a/arch/arm/mach-mx3/mach-mx35pdk.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
similarity index 96%
rename from arch/arm/mach-mx3/mach-mx35pdk.c
rename to arch/arm/mach-mx3/mach-mx35_3ds.c
index bcac84d..66ad2da 100644
--- a/arch/arm/mach-mx3/mach-mx35pdk.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -18,6 +18,12 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+/*
+ * This machine is known as:
+ *  - i.MX35 3-Stack Development System
+ *  - i.MX35 Platform Development Kit (i.MX35 PDK)
+ */
+
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-- 
1.7.0
