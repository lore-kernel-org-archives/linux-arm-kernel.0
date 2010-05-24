From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:51 +0200
Subject: [PATCH 16/16] arm/mxc: grammar fix
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 .../plat-mxc/include/mach/board-eukrea_cpuimx27.h  |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31lilly.h   |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31lite.h    |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    2 +-
 arch/arm/plat-mxc/include/mach/board-pcm038.h      |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx27.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx27.h
index a1fd583..45b2fb8 100644
--- a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx27.h
+++ b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx27.h
@@ -25,7 +25,7 @@
 #ifndef __ASSEMBLY__
 /*
  * This CPU module needs a baseboard to work. After basic initializing
- * its own devices, it calls baseboard's init function.
+ * its own devices, it calls the baseboard's init function.
  * TODO: Add your own baseboard init function and call it from
  * inside eukrea_cpuimx27_init().
  *
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31lilly.h b/arch/arm/plat-mxc/include/mach/board-mx31lilly.h
index eb5a502..0df71bf 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31lilly.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31lilly.h
@@ -31,7 +31,7 @@ enum mx31lilly_boards {
 
 /*
  * This CPU module needs a baseboard to work. After basic initializing
- * its own devices, it calls baseboard's init function.
+ * its own devices, it calls the baseboard's init function.
  */
 
 extern void mx31lilly_db_init(void);
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31lite.h b/arch/arm/plat-mxc/include/mach/board-mx31lite.h
index 2b2da03..c1ad0ae 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31lite.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31lite.h
@@ -32,7 +32,7 @@ enum mx31lite_boards {
 
 /*
  * This CPU module needs a baseboard to work. After basic initializing
- * its own devices, it calls baseboard's init function.
+ * its own devices, it calls the baseboard's init function.
  */
 
 extern void mx31lite_db_init(void);
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h b/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
index fc5fec9..bf494e3 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
@@ -30,7 +30,7 @@ enum mx31moboard_boards {
 
 /*
  * This CPU module needs a baseboard to work. After basic initializing
- * its own devices, it calls baseboard's init function.
+ * its own devices, it calls the baseboard's init function.
  */
 
 extern void mx31moboard_devboard_init(void);
diff --git a/arch/arm/plat-mxc/include/mach/board-pcm038.h b/arch/arm/plat-mxc/include/mach/board-pcm038.h
index 410f978..6f371e3 100644
--- a/arch/arm/plat-mxc/include/mach/board-pcm038.h
+++ b/arch/arm/plat-mxc/include/mach/board-pcm038.h
@@ -22,7 +22,7 @@
 #ifndef __ASSEMBLY__
 /*
  * This CPU module needs a baseboard to work. After basic initializing
- * its own devices, it calls baseboard's init function.
+ * its own devices, it calls the baseboard's init function.
  * TODO: Add your own baseboard init function and call it from
  * inside pcm038_init().
  *
-- 
1.7.0
