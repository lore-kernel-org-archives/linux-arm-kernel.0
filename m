From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:21 +0100
Subject: [PATCH 04/11] ARM64: Prepare Actions Semi S900
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <20170215165528.10052-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARCH_OWL.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 129cc5a..5ecb925 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -1,5 +1,10 @@
 menu "Platform selection"
 
+config ARCH_OWL
+	bool "Actions Semi S900 SoC Family"
+	help
+	  This enables support for the Actions Semiconductor S900 SoC family.
+
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select GENERIC_IRQ_CHIP
-- 
2.10.2
