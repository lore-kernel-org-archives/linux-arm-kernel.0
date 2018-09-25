From: qader.aymen@gmail.com (Aymen Qader)
Date: Tue, 25 Sep 2018 09:34:00 +0100
Subject: [PATCH v3 2/2] staging: bcm2835-camera: Remove unused header
In-Reply-To: <20180925083401.22533-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
Message-ID: <20180925083401.22533-6-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the asm/cacheflush.h header include from mmal-vchiq.c. This
dependency was removed in:

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations")

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 51e5b04ff0f5..6e5c1d4ee122 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/vmalloc.h>
-#include <asm/cacheflush.h>
 #include <media/videobuf2-vmalloc.h>
 
 #include "mmal-common.h"
-- 
2.17.1
