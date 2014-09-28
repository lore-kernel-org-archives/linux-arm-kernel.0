From: voice.shen@atmel.com (Bo Shen)
Date: Sun, 28 Sep 2014 09:57:18 +0800
Subject: [PATCH 1/2] MAINTAINERS: add atmel ssc driver maintainer entry
Message-ID: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3705430..c004e6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1703,6 +1703,13 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/spi/spi-atmel.*
 
+ATMEL SSC DRIVER
+M:	Bo Shen <voice.shen@atmel.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/misc/atmel-ssc.c
+F:	include/linux/atmel-ssc.h
+
 ATMEL Timer Counter (TC) AND CLOCKSOURCE DRIVERS
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.1.0.24.g4109c28
