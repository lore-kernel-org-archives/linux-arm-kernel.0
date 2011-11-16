From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 Nov 2011 08:41:02 +0100
Subject: [PATCH 1/3] ARM i.MX5: remove unnecessary includes from board files
In-Reply-To: <1321429264-25834-1-git-send-email-s.hauer@pengutronix.de>
References: <1321429264-25834-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1321429264-25834-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx53_ard.c  |    1 -
 arch/arm/mach-mx5/board-mx53_evk.c  |    1 -
 arch/arm/mach-mx5/board-mx53_loco.c |    1 -
 arch/arm/mach-mx5/board-mx53_smd.c  |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 0d7f0ff..b88a2bc 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -32,7 +32,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include "crm_regs.h"
 #include "devices-imx53.h"
 
 #define ARD_ETHERNET_INT_B	IMX_GPIO_NR(2, 31)
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 6bea31a..c69413d 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -37,7 +37,6 @@
 #define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
 #define MX53EVK_LED		IMX_GPIO_NR(7, 7)
 
-#include "crm_regs.h"
 #include "devices-imx53.h"
 
 static iomux_v3_cfg_t mx53_evk_pads[] = {
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 7678f77..e64a8f7 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -32,7 +32,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include "crm_regs.h"
 #include "devices-imx53.h"
 
 #define MX53_LOCO_POWER			IMX_GPIO_NR(1, 8)
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index 59c0845..d498573 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -31,7 +31,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include "crm_regs.h"
 #include "devices-imx53.h"
 
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
-- 
1.7.7.1
