From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 17 Dec 2015 08:47:03 -0700
Subject: [PATCH 2/2] coresight: Fix a typo in Kconfig
In-Reply-To: <1450367223-21068-1-git-send-email-mathieu.poirier@linaro.org>
References: <1450367223-21068-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1450367223-21068-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Andrew F. Davis" <afd@ti.com>

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 6c8921140f02..c85935f3525a 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -8,7 +8,7 @@ menuconfig CORESIGHT
 	  This framework provides a kernel interface for the CoreSight debug
 	  and trace drivers to register themselves with. It's intended to build
 	  a topological view of the CoreSight components based on a DT
-	  specification and configure the right serie of components when a
+	  specification and configure the right series of components when a
 	  trace source gets enabled.
 
 if CORESIGHT
-- 
2.1.4
