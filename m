From: voice.shen@atmel.com (Bo Shen)
Date: Sun, 28 Sep 2014 09:57:19 +0800
Subject: [PATCH 2/2] MAINTAINERS: add atmel audio alsa driver maintainer entry
In-Reply-To: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
References: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1411869439-2719-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c004e6f..30f92cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1665,6 +1665,12 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
+ATMEL Audio ALSA driver
+M:	Bo Shen <voice.shen@atmel.com>
+L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/soc/atmel
+
 ATMEL DMA DRIVER
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.1.0.24.g4109c28
