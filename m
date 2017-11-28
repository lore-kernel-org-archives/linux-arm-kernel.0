From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 28 Nov 2017 12:13:53 +0900
Subject: [PATCH] MAINTAINERS: exclude other Socionext SoC DT files from
 ARM/UNIPHIER entry
Message-ID: <1511838833-26663-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several product lines in Socionext.  I maintain only
DT files prefixed with "uniphier".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52f..cbb89bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2046,7 +2046,7 @@ F:	arch/arm/boot/dts/uniphier*
 F:	arch/arm/include/asm/hardware/cache-uniphier.h
 F:	arch/arm/mach-uniphier/
 F:	arch/arm/mm/cache-uniphier.c
-F:	arch/arm64/boot/dts/socionext/
+F:	arch/arm64/boot/dts/socionext/uniphier*
 F:	drivers/bus/uniphier-system-bus.c
 F:	drivers/clk/uniphier/
 F:	drivers/gpio/gpio-uniphier.c
-- 
2.7.4
