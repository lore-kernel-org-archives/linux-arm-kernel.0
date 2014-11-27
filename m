From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 27 Nov 2014 17:06:34 +0100
Subject: [PATCH 06/11] ARM: at91/trivial: update Kconfig comment to mention
 SAMA5
In-Reply-To: <cover.1417103399.git.nicolas.ferre@atmel.com>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
Message-ID: <6250565cabb0034e3de4e8591b4da096c28609f6.1417103399.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A5 SAMA5 processors were not listed, add this in the AT91 comment.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 28f320589aa7..92dbde801d9c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -380,7 +380,7 @@ config ARCH_AT91
 	select USE_OF
 	help
 	  This enables support for systems based on Atmel
-	  AT91RM9200 and AT91SAM9* processors.
+	  AT91RM9200, AT91SAM9 and SAMA5 processors.
 
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
-- 
2.1.3
