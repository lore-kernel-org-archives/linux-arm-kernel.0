From: nikai@nikai.net (Nicolas Kaiser)
Date: Mon, 4 Oct 2010 12:39:37 +0200
Subject: [PATCH 4/5] arm/omap: remove duplicated include
In-Reply-To: <20101004122436.7092868f@absol.kitzblitz>
References: <20101004122436.7092868f@absol.kitzblitz>
Message-ID: <20101004123937.4493b01b@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/mach-omap2/board-cm-t35.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e10bc10..3308119 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -237,8 +237,6 @@ static inline void cm_t35_init_nand(void) {}
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 #include <linux/spi/ads7846.h>
 
-#include <plat/mcspi.h>
-
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,	/* 0: slave, 1: master */
-- 
1.7.2.2
