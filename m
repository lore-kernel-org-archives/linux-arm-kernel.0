From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Thu, 25 Mar 2010 18:22:33 +0100
Subject: [PATCH 02/16] ARM mach-mx3: duplicated include
In-Reply-To: <1269537767-7553-1-git-send-email-andrea.gelmini@gelma.net>
References: <1269537767-7553-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1269537767-7553-3-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mx3/mach-pcm037.c: linux/fsl_devices.h is included more than once.

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
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
1.7.0.3.296.g9776a
