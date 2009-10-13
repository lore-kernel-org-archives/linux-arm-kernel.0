From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Oct 2009 18:17:04 -0400
Subject: [PATCH] ep93xx: remove ep93xx_init_time() prototype
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB8075@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused prototype for ep93xx_init_time().  This function
is not defined in the kernel.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index a3ec33f..469fd96 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -17,7 +17,6 @@ struct ep93xx_eth_data
 
 void ep93xx_map_io(void);
 void ep93xx_init_irq(void);
-void ep93xx_init_time(unsigned long);
 
 /* EP93xx System Controller software locked register write */
 void ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg); 
