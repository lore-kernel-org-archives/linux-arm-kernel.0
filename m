From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Dec 2017 12:30:54 +0100
Subject: [PATCH] MAINTAINERS: Add self as extended maintainer for a slew of
 files
Message-ID: <20171220113054.10332-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take over sole maintenance of Nomadik, U300 and Ux500. Since all are
Device Tree converted and using standard format drivers this is not
burdensome. Alessandro is not working on this platform any more.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly where appropriate.
---
 MAINTAINERS | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..ac14e81ed38b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1634,14 +1634,18 @@ ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
 
-ARM/NOMADIK ARCHITECTURE
-M:	Alessandro Rubini <rubini@unipv.it>
+ARM/NOMADIK/U300/Ux500 ARCHITECTURE
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-nomadik/
+F:	arch/arm/mach-u300/
+F:	arch/arm/mach-ux500/
+F:	arch/arm/boot/dts/ste-*
 F:	drivers/pinctrl/nomadik/
 F:	drivers/i2c/busses/i2c-nomadik.c
+F:	Documentation/devicetree/bindings/arm/ste-*
+F:	Documentation/devicetree/bindings/arm/ux500/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 
 ARM/NUVOTON W90X900 ARM ARCHITECTURE
-- 
2.14.3
