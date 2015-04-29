From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Apr 2015 09:40:52 +0200
Subject: [PATCH] MAINTAINERS: replace an AT91 maintainer
Message-ID: <1430293252-9167-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As some help is needed from an active maintainer, replace Andrew Victor
by Alexandre Belloni in the ARM/Atmel MAINTAINERS' entry (aka AT91).

Thanks Andrew for the great role you played during the early days of this
product family.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index be26fc584cc6..1512e958082a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -892,11 +892,10 @@ S:	Maintained
 F:	arch/arm/mach-alpine/
 
 ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES
-M:	Andrew Victor <linux@maxim.org.za>
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
 M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-W:	http://maxim.org.za/at91_26.html
 W:	http://www.linux4sam.org
 S:	Supported
 F:	arch/arm/mach-at91/
-- 
2.1.3
