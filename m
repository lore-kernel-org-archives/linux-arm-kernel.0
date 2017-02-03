From: hendrik@consetetur.de (Hendrik v. Raven)
Date: Fri,  3 Feb 2017 17:17:27 +0100
Subject: [PATCH] staging: bcm2835-audio: fix spacing of macro
Message-ID: <20170203161733.5930-1-hendrik@consetetur.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

removes the unwanted spaces inside of sizeof( ), removing a complaint of
checkpatch.pl. Also removes the second space behind the macro name.

Signed-off-by: Hendrik v. Raven <hendrik@consetetur.de>
---
 drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h b/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
index 09f07fd891bb..dd2f162b1ccb 100644
--- a/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
+++ b/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
@@ -22,7 +22,7 @@
 #define VC_AUDIO_SERVER_NAME  MAKE_FOURCC("AUDS")
 
 /* Maximum message length */
-#define VC_AUDIO_MAX_MSG_LEN  (sizeof( VC_AUDIO_MSG_T ))
+#define VC_AUDIO_MAX_MSG_LEN (sizeof(VC_AUDIO_MSG_T))
 
 /*
  *  List of screens that are currently supported
-- 
2.11.0
