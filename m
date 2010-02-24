From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:05 +0100
Subject: [PATCH 10/39] arm/mx2/devices: no need for
	IMX_NEEDS_DEPRECATED_SYMBOLS any more
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous commits cleaned up arch/arm/mach-mx2/devices.c such that it
doesn't rely on deprecated symbols any more.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-mx2/Makefile
index e891090..ce10d41 100644
--- a/arch/arm/mach-mx2/Makefile
+++ b/arch/arm/mach-mx2/Makefile
@@ -6,7 +6,6 @@
 
 obj-y	:=  generic.o devices.o serial.o
 CFLAGS_generic.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
-CFLAGS_devices.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 
 obj-$(CONFIG_MACH_MX21) += clock_imx21.o
 
-- 
1.6.6.2
