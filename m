From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Thu,  8 Apr 2010 19:50:27 +0800
Subject: [PATCH 12/16] i.MX31 pcm037: remove duplicated #include
Message-ID: <1270727427-840-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-mx3/mach-pcm037.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-mx3/mach-pcm037.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 034ec81..2df1ec5 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -35,7 +35,6 @@
 #include <linux/can/platform/sja1000.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-#include <linux/fsl_devices.h>
 #include <linux/gfp.h>
 
 #include <media/soc_camera.h>
-- 
1.6.1.3
