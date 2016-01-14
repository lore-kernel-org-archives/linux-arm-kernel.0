From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 14 Jan 2016 16:38:14 +0100
Subject: [PATCH v3 2/5] MAINTAINERS: add entry for Atmel ADC 8xx driver
In-Reply-To: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
References: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1452785897-16270-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dac3be0..113900c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1951,6 +1951,12 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
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
