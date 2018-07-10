From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 10 Jul 2018 22:35:02 +0200
Subject: [PATCH v2 09/18] drm/sun4i: mixer: Order includes alphabetically
In-Reply-To: <20180710203511.18454-1-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
Message-ID: <20180710203511.18454-10-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Includes are not alphabetically ordered.

Reorder them.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index ee8febb25903..aa81b9838ae8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -21,8 +21,8 @@
 
 #include <linux/component.h>
 #include <linux/dma-mapping.h>
-#include <linux/reset.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 
 #include "sun4i_drv.h"
 #include "sun8i_mixer.h"
-- 
2.18.0
