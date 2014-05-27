From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 27 May 2014 13:39:28 +0200
Subject: [PATCH] MAINTAINERS: add AT91 Clock Support entry
Message-ID: <1401190768-3932-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1066264..40c5580 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -808,6 +808,11 @@ F:	arch/arm/boot/dts/at91*.dtsi
 F:	arch/arm/boot/dts/sama*.dts
 F:	arch/arm/boot/dts/sama*.dtsi
 
+ARM/ATMEL AT91 Clock Support
+M:	Boris Brezillon <boris.brezillon@free-electrons.com>
+S:	Maintained
+F:	drivers/clk/at91
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.8.3.2
