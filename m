From: stefan@agner.ch (Stefan Agner)
Date: Sun, 26 Jun 2016 01:47:51 -0700
Subject: [PATCH v2 1/5] ARM: imx: add support for i.MX 7Solo
In-Reply-To: <20160626084755.21925-1-stefan@agner.ch>
References: <20160626084755.21925-1-stefan@agner.ch>
Message-ID: <20160626084755.21925-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree compatible string "imx7s" for i.MX 7Solo.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/mach-imx7d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index b450f52..36254a6 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -107,6 +107,7 @@ static void __init imx7d_init_irq(void)
 
 static const char *const imx7d_dt_compat[] __initconst = {
 	"fsl,imx7d",
+	"fsl,imx7s",
 	NULL,
 };
 
-- 
2.8.3
