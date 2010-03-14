From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Sun, 14 Mar 2010 10:56:40 +0800
Subject: [PATCH 1/3] MX3: pcm037: remove duplicated #include
Message-ID: <1268535400-296-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-mx3/mach-pcm037.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-mx3/mach-pcm037.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 11f5315..a550ae9 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -35,7 +35,6 @@
 #include <linux/can/platform/sja1000.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-#include <linux/fsl_devices.h>
 
 #include <media/soc_camera.h>
 
-- 
1.6.1.3
