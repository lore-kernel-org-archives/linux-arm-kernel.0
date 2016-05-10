From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 10 May 2016 20:59:57 +0200
Subject: [PATCH -trivial 2/3] ARM: Spelling s/paltform/platform/g
In-Reply-To: <1462906798-27993-1-git-send-email-geert+renesas@glider.be>
References: <1462906798-27993-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1462906798-27993-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2d756aa471f33316..c01039b81d6eeb13 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -897,7 +897,7 @@ config MACH_STM32F429
 	default y
 
 config ARCH_MPS2
-	bool "ARM MPS2 paltform"
+	bool "ARM MPS2 platform"
 	depends on ARM_SINGLE_ARMV7M
 	select ARM_AMBA
 	select CLKSRC_MPS2
-- 
1.9.1
