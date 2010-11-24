From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Nov 2010 15:53:03 +0000
Subject: [PATCH] ARM: Samsung: Make sure ASoC DMA device is prototyped
Message-ID: <1290613983-1291-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the prototype agrees with the definition and stop sparse
complaining when building the file.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/dev-asocdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-asocdma.c b/arch/arm/plat-samsung/dev-asocdma.c
index b7b1fca..a068c4f 100644
--- a/arch/arm/plat-samsung/dev-asocdma.c
+++ b/arch/arm/plat-samsung/dev-asocdma.c
@@ -10,6 +10,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <plat/devs.h>
 
 static u64 audio_dmamask = DMA_BIT_MASK(32);
 
-- 
1.7.1
