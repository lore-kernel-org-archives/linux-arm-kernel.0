From: martin@kaiser.cx (Martin Kaiser)
Date: Thu, 1 Sep 2016 22:48:16 +0200
Subject: [PATCH] ARM: imx: (trivial) fix a typo
Message-ID: <20160901204816.GA8057@reykholt.kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/mach-imx/hardware.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index a42a6df..2810ffc 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -120,7 +120,7 @@
 	.type = _type,							\
 }
 
-/* There's a off-by-one betweem the gpio bank number and the gpiochip */
+/* There's a off-by-one between the gpio bank number and the gpiochip */
 /* range e.g. GPIO_1_5 is gpio 5 under linux */
 #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
 
-- 
1.7.10.4
