From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 22 Jun 2017 16:35:48 +0300
Subject: [PATCH 02/14] staging: fsl-mc: drop useless #includes
In-Reply-To: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
References: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
Message-ID: <20170622133600.31694-3-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

These couple of header files are not needed in the source
so remove them.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
index 9291847..c2af5b5 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
@@ -13,8 +13,6 @@
 #include "../include/mc-bus.h"
 #include "../include/mc-sys.h"
 
-#include "dpbp-cmd.h"
-#include "dpcon-cmd.h"
 #include "fsl-mc-private.h"
 
 static bool __must_check fsl_mc_is_allocatable(const char *obj_type)
-- 
2.9.4
