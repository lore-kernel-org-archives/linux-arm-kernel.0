From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Apr 2012 13:54:45 +0200
Subject: [PATCH 4/5] MAINTAINERS: add entry for Atmel timer counter (TC)
In-Reply-To: <cover.1334137680.git.nicolas.ferre@atmel.com>
References: <cover.1334137680.git.nicolas.ferre@atmel.com>
Message-ID: <d8f2e44af30ba7fc2c40e614ea17d40cc82c374c.1334137680.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry for the Timer Counter (TC) library and the clocksource
driver that is using this library.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fc6a6c..be04d43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1363,6 +1363,13 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/spi/spi-atmel.*
 
+ATMEL Timer Counter (TC) AND CLOCKSOURCE DRIVERS
+M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/misc/atmel_tclib.c
+F:	drivers/clocksource/tcb_clksrc.c
+
 ATMEL TSADCC DRIVER
 M:	Josh Wu <josh.wu@atmel.com>
 L:	linux-input at vger.kernel.org
-- 
1.7.9.4
