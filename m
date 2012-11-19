From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 19 Nov 2012 12:07:06 -0200
Subject: [PATCH v3 2/3] ARM: mx27: Align IIM registers with Reference Manual
In-Reply-To: <1353334027-30009-1-git-send-email-fabio.estevam@freescale.com>
References: <1353334027-30009-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1353334027-30009-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Align IIM registers with mx27 Reference Manual.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- No changes. Newly introduced on this series
 arch/arm/mach-imx/iim.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/iim.h b/arch/arm/mach-imx/iim.h
index 315bffa..d1d6f35 100644
--- a/arch/arm/mach-imx/iim.h
+++ b/arch/arm/mach-imx/iim.h
@@ -36,11 +36,11 @@
 #define MXC_IIMSCS1             0x0030
 #define MXC_IIMSCS2             0x0034
 #define MXC_IIMSCS3             0x0038
-#define MXC_IIMFBAC0            0x0800
-#define MXC_IIMJAC              0x0804
-#define MXC_IIMHWV1             0x0808
-#define MXC_IIMHWV2             0x080C
-#define MXC_IIMHAB0             0x0810
+#define MXC_IIMFBAC0            0x003C
+#define MXC_IIMWORD1_BANK0	0x0804
+#define MXC_IIMWORD2_BANK0	0x0808
+#define MXC_IIMWORD3_BANK0	0x080C
+#define MXC_IIMWORD4_BANK0	0x0810
 #define MXC_IIMHAB1             0x0814
 /* Definitions for i.MX27 TO2 */
 #define MXC_IIMMAC              0x0814
-- 
1.7.9.5
