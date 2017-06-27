From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 27 Jun 2017 17:41:23 +0300
Subject: [PATCH v2 03/15] staging: fsl-mc: drop useless #includes
In-Reply-To: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
References: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
Message-ID: <20170627144135.15599-4-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

These couple of header files are not needed in the source
so remove them.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v2:
 - no changes

 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
index d34e2ff..d9a06b9 100644
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
