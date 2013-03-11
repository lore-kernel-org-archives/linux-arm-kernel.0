From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 11 Mar 2013 14:16:00 +0100
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
Message-ID: <1363007760.3137.69.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested by grepping the tree.

1) Typo was added in commit f8c95fe6d9adad72fc7bce90f4ab68d119f50c5b
("ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs").
Looking at that patch and at the tree makes clear that DEBUG_IMX53_UART
was intended here.

 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..ecfcdba 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -492,7 +492,7 @@ config DEBUG_IMX_UART_PORT
 						DEBUG_IMX31_UART || \
 						DEBUG_IMX35_UART || \
 						DEBUG_IMX51_UART || \
-						DEBUG_IMX50_IMX53_UART || \
+						DEBUG_IMX53_UART || \
 						DEBUG_IMX6Q_UART
 	default 1
 	help
-- 
1.7.11.7
