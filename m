From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:05 +0100
Subject: [PATCH 37/51] ARM: mx25: remove now empty devices.h
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-37-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c |    1 -
 arch/arm/mach-mx25/mach-cpuimx25.c            |    1 -
 arch/arm/mach-mx25/mach-mx25_3ds.c            |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)
 delete mode 100644 arch/arm/mach-mx25/devices.h

diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
deleted file mode 100644
index e69de29..0000000
diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
index d6058e0..75a5db5 100644
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
@@ -36,7 +36,6 @@
 #include <mach/audmux.h>
 
 #include "devices-imx25.h"
-#include "devices.h"
 
 static struct pad_desc eukrea_mbimxsd_pads[] = {
 	/* LCD */
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index d1a04ba..67a7d55 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -41,7 +41,6 @@
 #include <mach/iomux-mx25.h>
 
 #include "devices-imx25.h"
-#include "devices.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index 7e72df7..328e1af 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -42,7 +42,6 @@
 #include <mach/iomux-mx25.h>
 
 #include "devices-imx25.h"
-#include "devices.h"
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
-- 
1.7.2.3
