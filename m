From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 15 Jan 2016 09:54:18 +0100
Subject: [RESEND PATCH v3 2/5] MAINTAINERS: add entry for Atmel SAMA5D2 ADC
 driver
In-Reply-To: <1452785897-16270-3-git-send-email-ludovic.desroches@atmel.com>
References: <1452785897-16270-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1452848058-32068-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

I have forgotten to update this patch with the new name of the driver.

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dac3be0..144422c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1951,6 +1951,12 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
+ATMEL SAMA5D2 ADC DRIVER
+M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+L:	linux-iio at vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/at91-sama5d2_adc.c
+
 ATMEL Audio ALSA driver
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-- 
2.5.0
