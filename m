From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:13 +0100
Subject: [PATCH 06/25] imx/mx3: rename clock.c and iomux.c to {clock,
	iomux}-imx31.c
In-Reply-To: <1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These files are only used on imx31.  This makes the name consistent with
the imx35 files.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/Makefile                   |    2 +-
 arch/arm/mach-mx3/{clock.c => clock-imx31.c} |    0
 arch/arm/mach-mx3/{iomux.c => iomux-imx31.c} |    0
 3 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-mx3/{clock.c => clock-imx31.c} (100%)
 rename arch/arm/mach-mx3/{iomux.c => iomux-imx31.c} (100%)

diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 93c7b29..03e25d6 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-y				:= mm.o devices.o cpu.o
-obj-$(CONFIG_ARCH_MX31)		+= clock.o iomux.o
+obj-$(CONFIG_ARCH_MX31)		+= clock-imx31.o iomux-imx31.o
 obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o
 obj-$(CONFIG_MACH_MX31ADS)	+= mx31ads.o
 obj-$(CONFIG_MACH_MX31LILLY)	+= mx31lilly.o mx31lilly-db.o
diff --git a/arch/arm/mach-mx3/clock.c b/arch/arm/mach-mx3/clock-imx31.c
similarity index 100%
rename from arch/arm/mach-mx3/clock.c
rename to arch/arm/mach-mx3/clock-imx31.c
diff --git a/arch/arm/mach-mx3/iomux.c b/arch/arm/mach-mx3/iomux-imx31.c
similarity index 100%
rename from arch/arm/mach-mx3/iomux.c
rename to arch/arm/mach-mx3/iomux-imx31.c
-- 
1.6.5.2
