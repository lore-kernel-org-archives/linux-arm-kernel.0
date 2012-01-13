From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jan 2012 10:34:03 -0600
Subject: [RFC PATCH 02/10] sound: pxa2xx-ac97: include mach/irqs.h directly
In-Reply-To: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326472451-9002-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation of removing mach/irqs.h include from asm/irq.h, include
mach/irqs.h directly.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 sound/arm/pxa2xx-ac97-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index d1aa421..0e9e822 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -21,7 +21,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/pxa2xx-lib.h>
 
-#include <asm/irq.h>
+#include <mach/irqs.h>
 #include <mach/regs-ac97.h>
 #include <mach/audio.h>
 
-- 
1.7.5.4
