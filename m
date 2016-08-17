From: petr.cvek@tul.cz (Petr Cvek)
Date: Wed, 17 Aug 2016 12:36:13 +0200
Subject: [PATCH] ARM: pxa: magician: Remove duplicated I2C pins declaration
Message-ID: <823cff5b-6b6f-0042-d536-570a6df241a8@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magician has GPIO117_I2C_SCL and GPIO118_I2C_SDA pins declared twice.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index abc9181..6f8837e 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -121,10 +121,6 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO107_GPIO,	/* DS1WM_IRQ */
 	GPIO108_GPIO,	/* GSM_READY */
 	GPIO115_GPIO,	/* nPEN_IRQ */
-
-	/* I2C */
-	GPIO117_I2C_SCL,
-	GPIO118_I2C_SDA,
 };
 
 /*
-- 
2.9.2
