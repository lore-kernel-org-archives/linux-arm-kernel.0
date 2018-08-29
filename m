From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:37 +0200
Subject: [PATCH 01/11] MAINTAINERS: ARM: at91: add co-maintainer for
 ARM/Microchip
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <8c4937512d9535441b9f0aa4c27aeb4edf526489.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ludovic as a new co-maintainer for the AT91 Microchip ARM
sub-architecture.
Add the newly created kernel.org group git tree that we will use
from now on.

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..7f97f1f83398 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1703,9 +1703,10 @@ S:	Odd Fixes
 ARM/Microchip (AT91) SoC support
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.linux4sam.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
 S:	Supported
 N:	at91
 N:	atmel
-- 
2.17.1
