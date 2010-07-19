From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 12:58:57 +0200
Subject: [PATCH 2/9] [ARM] pxa/corgi: remove unused declarations of
	corgiscoop_device
In-Reply-To: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
References: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1279537144-25424-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/corgi.c              |    2 --
 arch/arm/mach-pxa/include/mach/corgi.h |    5 -----
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 51ffa6a..34ddc3a 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -185,8 +185,6 @@ static struct scoop_pcmcia_config corgi_pcmcia_config = {
 	.num_devs     = 1,
 };
 
-EXPORT_SYMBOL(corgiscoop_device);
-
 static struct w100_mem_info corgi_fb_mem = {
 	.ext_cntl          = 0x00040003,
 	.sdram_mode_reg    = 0x00650021,
diff --git a/arch/arm/mach-pxa/include/mach/corgi.h b/arch/arm/mach-pxa/include/mach/corgi.h
index 585970e..0011055 100644
--- a/arch/arm/mach-pxa/include/mach/corgi.h
+++ b/arch/arm/mach-pxa/include/mach/corgi.h
@@ -109,10 +109,5 @@
 #define CORGI_GPIO_BACKLIGHT_CONT	(CORGI_SCOOP_GPIO_BASE + 7)
 #define CORGI_GPIO_MIC_BIAS		(CORGI_SCOOP_GPIO_BASE + 8)
 
-/*
- * Shared data structures
- */
-extern struct platform_device corgiscoop_device;
-
 #endif /* __ASM_ARCH_CORGI_H  */
 
-- 
1.7.1
