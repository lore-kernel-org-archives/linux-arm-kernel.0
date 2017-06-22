From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 22 Jun 2017 16:35:51 +0300
Subject: [PATCH 05/14] staging: fsl-mc: delete prototype of unimplemented
 function
In-Reply-To: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
References: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
Message-ID: <20170622133600.31694-6-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The function fsl_mc_bus_exists() has a prototype but is never
implemented so delete it from the header file.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/include/mc-bus.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fsl-mc/include/mc-bus.h b/drivers/staging/fsl-mc/include/mc-bus.h
index 8f9bf8d..aac062e 100644
--- a/drivers/staging/fsl-mc/include/mc-bus.h
+++ b/drivers/staging/fsl-mc/include/mc-bus.h
@@ -91,8 +91,6 @@ void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
 
 void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
 
-bool fsl_mc_bus_exists(void);
-
 void fsl_mc_get_root_dprc(struct device *dev,
 			  struct device **root_dprc_dev);
 
-- 
2.9.4
