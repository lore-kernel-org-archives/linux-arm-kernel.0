From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 4 Apr 2011 10:19:26 -0300
Subject: [PATCH] ARM: mx3/pcm043: Remove unneeded esdhc.h define
Message-ID: <1301923166-13220-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"devices-imx35.h" includes <mach/devices-common.h>; and the latter
includes <mach/esdhc.h>, so no need to include it again in mach-pcm043.c.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/mach-pcm043.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 036ba1a..9caf38b 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -40,7 +40,6 @@
 #include <mach/mx3fb.h>
 #include <mach/ulpi.h>
 #include <mach/audmux.h>
-#include <mach/esdhc.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
-- 
1.6.0.4
