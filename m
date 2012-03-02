From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:21 -0600
Subject: [PATCH v3 09/30] [media] davinci: remove includes of mach/io.h
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove a few remaining includes of mach/io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
---
 drivers/media/video/davinci/vpbe_osd.c  |    1 -
 drivers/media/video/davinci/vpbe_venc.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/davinci/vpbe_osd.c b/drivers/media/video/davinci/vpbe_osd.c
index d6488b7..bba299d 100644
--- a/drivers/media/video/davinci/vpbe_osd.c
+++ b/drivers/media/video/davinci/vpbe_osd.c
@@ -28,7 +28,6 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 
-#include <mach/io.h>
 #include <mach/cputype.h>
 #include <mach/hardware.h>
 
diff --git a/drivers/media/video/davinci/vpbe_venc.c b/drivers/media/video/davinci/vpbe_venc.c
index 00e80f5..b21ecc8 100644
--- a/drivers/media/video/davinci/vpbe_venc.c
+++ b/drivers/media/video/davinci/vpbe_venc.c
@@ -27,7 +27,6 @@
 
 #include <mach/hardware.h>
 #include <mach/mux.h>
-#include <mach/io.h>
 #include <mach/i2c.h>
 
 #include <linux/io.h>
-- 
1.7.5.4
