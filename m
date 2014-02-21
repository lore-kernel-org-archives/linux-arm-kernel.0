From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:15 +0900
Subject: [PATCH 03/16] ARM: shmobile: lager legacy: Add QSPI pinmux
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <248deabbd4a2f4c696338536fdaad3a01f66bee7.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 90d7e81..72886af 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -649,6 +649,11 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* I2C2 */
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-rcar.2", "pfc-r8a7790",
 				  "i2c2", "i2c2"),
+	/* QSPI */
+	PIN_MAP_MUX_GROUP_DEFAULT("qspi.0", "pfc-r8a7790",
+				  "qspi_ctrl", "qspi"),
+	PIN_MAP_MUX_GROUP_DEFAULT("qspi.0", "pfc-r8a7790",
+				  "qspi_data4", "qspi"),
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
 				  "scif0_data", "scif0"),
-- 
1.8.5.2
