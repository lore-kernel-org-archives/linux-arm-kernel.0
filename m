From: hendrik@consetetur.de (Hendrik v. Raven)
Date: Tue, 14 Feb 2017 10:35:15 +0100
Subject: [PATCH v2] staging: bcm2835-audio: remove unused macro
In-Reply-To: <20170205104134.GA27798@kroah.com>
References: <1486142858.22276.63.camel@perches.com>
 <20170203185009.5909-1-hendrik@consetetur.de>
 <20170205104134.GA27798@kroah.com>
Message-ID: <20170214093514.GA10204@psyche>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VC_AUDIO_MAX_MSG_LEN macro is not used by anything in the
bcm2835-audio driver.

Signed-off-by: Hendrik v. Raven <hendrik@consetetur.de>
---
v2:
 - rebased against next-20170214

---
 drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h b/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
index 928dd6009510..da96f1bc2516 100644
--- a/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
+++ b/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
@@ -21,9 +21,6 @@
 /* FourCC code used for VCHI connection */
 #define VC_AUDIO_SERVER_NAME  MAKE_FOURCC("AUDS")
 
-/* Maximum message length */
-#define VC_AUDIO_MAX_MSG_LEN  (sizeof(VC_AUDIO_MSG_T))
-
 /*
  *  List of screens that are currently supported
  *  All message types supported for HOST->VC direction
-- 
2.11.0
