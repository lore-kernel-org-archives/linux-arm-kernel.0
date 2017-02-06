From: abhijitnaik27@gmail.com (Abhijit Naik)
Date: Mon,  6 Feb 2017 13:26:50 +0530
Subject: [PATCH 1/2] staging: bcm2835-audio: Removed spaces before ')'
Message-ID: <20170206075651.4829-1-abhijitnaik27@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2835-vchiq.c and vc_vchi_audioserv_defs.h:
fixing ERROR: space prohibited before that close parenthesis

Signed-off-by: Abhijit Naik <abhijitnaik27@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c          | 16 ++++++++--------
 drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index e8fd9c79bcfc..99dc8c4e0185 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
@@ -44,15 +44,15 @@

 /* Logging macros (for remapping to other logging mechanisms, i.e., printf) */
 #ifdef AUDIO_DEBUG_ENABLE
-#define LOG_ERR( fmt, arg... )   pr_err( "%s:%d " fmt, __func__, __LINE__, ##arg)
-#define LOG_WARN( fmt, arg... )  pr_info( "%s:%d " fmt, __func__, __LINE__, ##arg)
-#define LOG_INFO( fmt, arg... )  pr_info( "%s:%d " fmt, __func__, __LINE__, ##arg)
-#define LOG_DBG( fmt, arg... )   pr_info( "%s:%d " fmt, __func__, __LINE__, ##arg)
+#define LOG_ERR( fmt, arg...)   pr_err( "%s:%d " fmt, __func__, __LINE__, ##arg)
+#define LOG_WARN( fmt, arg...)  pr_info( "%s:%d " fmt, __func__, __LINE__, ##arg)
+#define LOG_INFO( fmt, arg...)  pr_info( "%s:%d " fmt, __func__, __LINE__, ##arg)
+#define LOG_DBG( fmt, arg...)   pr_info( "%s:%d " fmt, __func__, __LINE__, ##arg)
 #else
-#define LOG_ERR( fmt, arg... )   pr_err( "%s:%d " fmt, __func__, __LINE__, ##arg)
-#define LOG_WARN( fmt, arg... )
-#define LOG_INFO( fmt, arg... )
-#define LOG_DBG( fmt, arg... )
+#define LOG_ERR( fmt, arg...)   pr_err( "%s:%d " fmt, __func__, __LINE__, ##arg)
+#define LOG_WARN( fmt, arg...)
+#define LOG_INFO( fmt, arg...)
+#define LOG_DBG( fmt, arg...)
 #endif

 struct bcm2835_audio_instance {
diff --git a/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h b/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
index 09f07fd891bb..f88c5632918b 100644
--- a/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
+++ b/drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h
@@ -22,7 +22,7 @@
 #define VC_AUDIO_SERVER_NAME  MAKE_FOURCC("AUDS")

 /* Maximum message length */
-#define VC_AUDIO_MAX_MSG_LEN  (sizeof( VC_AUDIO_MSG_T ))
+#define VC_AUDIO_MAX_MSG_LEN  (sizeof( VC_AUDIO_MSG_T))

 /*
  *  List of screens that are currently supported
--
2.11.0
