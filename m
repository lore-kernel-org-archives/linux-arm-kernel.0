From: lars.persson@axis.com (Lars Persson)
Date: Wed, 10 Feb 2016 13:41:57 +0100
Subject: [PATCH 8/8] arm: mach-artpec: add entry to MAINTAINERS
In-Reply-To: <cover.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
Message-ID: <0b705a87e60c75c71721f3cf013b544eea746a95.1455107681.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lars Persson <larper@axis.com>
Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f1fa4f..d32c1aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -932,6 +932,16 @@ M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
 S:	Maintained
 F:	arch/arm/mach-alpine/
 
+ARM/ARTPEC MACHINE SUPPORT
+M:	Jesper Nilsson <jesper.nilsson@axis.com>
+M:	Lars Persson <lars.persson@axis.com>
+M:	Niklas Cassel <niklas.cassel@axis.com>
+S:	Maintained
+L:	linux-arm-kernel at axis.com
+F:	arch/arm/mach-artpec
+F:	arch/arm/boot/dts/artpec6*
+F:	drivers/clk/clk-artpec6.c
+
 ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
-- 
2.1.4
