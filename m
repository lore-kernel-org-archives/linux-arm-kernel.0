From: julien.boibessot@free.fr (julien.boibessot at free.fr)
Date: Thu, 24 Mar 2011 17:29:15 +0100
Subject: [PATCH] mx2/iomux: Set direction for CSPI2 pins
Message-ID: <1300984155-30280-1-git-send-email-julien.boibessot@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Boibessot <julien.boibessot@armadeus.com>


Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx2x.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx2x.h b/arch/arm/plat-mxc/include/mach/iomux-mx2x.h
index c4f116d..7a9b20a 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx2x.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx2x.h
@@ -90,12 +90,12 @@
 #define PC31_PF_SSI3_CLK	(GPIO_PORTC | GPIO_PF | GPIO_IN | 31)
 #define PD17_PF_I2C_DATA	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 17)
 #define PD18_PF_I2C_CLK		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 18)
-#define PD19_PF_CSPI2_SS2	(GPIO_PORTD | GPIO_PF | 19)
-#define PD20_PF_CSPI2_SS1	(GPIO_PORTD | GPIO_PF | 20)
-#define PD21_PF_CSPI2_SS0	(GPIO_PORTD | GPIO_PF | 21)
-#define PD22_PF_CSPI2_SCLK	(GPIO_PORTD | GPIO_PF | 22)
-#define PD23_PF_CSPI2_MISO	(GPIO_PORTD | GPIO_PF | 23)
-#define PD24_PF_CSPI2_MOSI	(GPIO_PORTD | GPIO_PF | 24)
+#define PD19_PF_CSPI2_SS2	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 19)
+#define PD20_PF_CSPI2_SS1	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 20)
+#define PD21_PF_CSPI2_SS0	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 21)
+#define PD22_PF_CSPI2_SCLK	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 22)
+#define PD23_PF_CSPI2_MISO	(GPIO_PORTD | GPIO_PF | GPIO_IN | 23)
+#define PD24_PF_CSPI2_MOSI	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 24)
 #define PD25_PF_CSPI1_RDY	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 25)
 #define PD26_PF_CSPI1_SS2	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 26)
 #define PD27_PF_CSPI1_SS1	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 27)
-- 
1.6.0.4
