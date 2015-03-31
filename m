From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 31 Mar 2015 15:34:51 +0200
Subject: [RESEND PATCH] MAINTAINERS: change the Atmel audio alsa driver entry
Message-ID: <1427808891-9321-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I take over the the maintainship of Atmel alsa drivers from Voice.
Thanks for your work!

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Bo Shen <voice.shen@atmel.com>
Cc: Mark Brown <broonie@kernel.org>
---
Hi Mark,

Here is the MAINTAINERS' change that I sent to the wrong address. Can you
please take it with your tree?

Thanks, bye.


 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cb40f8736ee..a915bb124fe7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1762,7 +1762,7 @@ S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
 ATMEL Audio ALSA driver
-M:	Bo Shen <voice.shen@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
-- 
2.1.3
