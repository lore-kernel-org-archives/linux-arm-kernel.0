From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Mar 2015 10:48:50 +0100
Subject: [PATCH 1/2] MAINTAINERS: change the Atmel audio alsa driver entry
Message-ID: <1426758530-7656-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I take over the the maintainship of Atmel alsa drivers from Voice.
Thanks for your work!

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Bo Shen <voice.shen@atmel.com>
Cc: Mark Brown <broonie@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8cf9a8a..679b2d0cb2d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1751,7 +1751,7 @@ S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
 ATMEL Audio ALSA driver
-M:	Bo Shen <voice.shen@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
-- 
2.1.3
