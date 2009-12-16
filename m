From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Dec 2009 19:59:49 +0100
Subject: [PATCH 08/20] imx/mx1: add newline at end of Makefile
In-Reply-To: <1260990002-24168-7-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091216185046.GA16984@pengutronix.de>
	<1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-7-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260990002-24168-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
---
 arch/arm/mach-mx1/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx1/Makefile b/arch/arm/mach-mx1/Makefile
index 7f86fe0..b72f536 100644
--- a/arch/arm/mach-mx1/Makefile
+++ b/arch/arm/mach-mx1/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_MX1_VIDEO)	+= ksym_mx1.o mx1_camera_fiq.o
 
 # Specific board support
 obj-$(CONFIG_ARCH_MX1ADS) += mx1ads.o
-obj-$(CONFIG_MACH_SCB9328) += scb9328.o
\ No newline at end of file
+obj-$(CONFIG_MACH_SCB9328) += scb9328.o
-- 
1.6.5.2
