From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 6 Jan 2016 17:12:36 +0100
Subject: [PATCH v2 2/5] MAINTAINERS: add entry for Atmel ADC 8xx driver
In-Reply-To: <1452096759-19438-1-git-send-email-ludovic.desroches@atmel.com>
References: <1452096759-19438-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1452096759-19438-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 248828d..827bc83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,6 +1945,12 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
+ATMEL ADC 8xx DRIVER
+M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+L:	linux-iio at vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/at91_adc8xx.c
+
 ATMEL Audio ALSA driver
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-- 
2.5.0
