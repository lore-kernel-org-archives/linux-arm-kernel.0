From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  4 Nov 2014 10:55:08 +0100
Subject: [PATCH 13/15] gpu: ipu-v3: Replace v4l2-mediabus.h inclusion with
 v4l2-mbus.h
In-Reply-To: <1415094910-15899-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415094910-15899-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415094910-15899-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v4l2-mediabus.h header is now deprecated and should be replaced with
v4l2-mbus.h.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/ipu-v3/ipu-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-csi.c b/drivers/gpu/ipu-v3/ipu-csi.c
index 752cdd2..8aea0de 100644
--- a/drivers/gpu/ipu-v3/ipu-csi.c
+++ b/drivers/gpu/ipu-v3/ipu-csi.c
@@ -21,7 +21,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/videodev2.h>
-#include <uapi/linux/v4l2-mediabus.h>
+#include <uapi/linux/v4l2-mbus.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
-- 
1.9.1
