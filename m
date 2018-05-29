From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 29 May 2018 10:09:01 +0100
Subject: [PATCH v4 01/15] ARM: add more CPU part numbers for Cortex and Brahma
 B15 CPUs
In-Reply-To: <20180529090756.GG17671@n2100.armlinux.org.uk>
References: <20180529090756.GG17671@n2100.armlinux.org.uk>
Message-ID: <E1fNacn-0000fJ-Ix@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPU part numbers for Cortex A53, A57, A72, A73, A75 and the
Broadcom Brahma B15 CPU.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/cputype.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb546425da8a..26021980504d 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -77,8 +77,16 @@
 #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
 #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
 #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
+#define ARM_CPU_PART_CORTEX_A53		0x4100d030
+#define ARM_CPU_PART_CORTEX_A57		0x4100d070
+#define ARM_CPU_PART_CORTEX_A72		0x4100d080
+#define ARM_CPU_PART_CORTEX_A73		0x4100d090
+#define ARM_CPU_PART_CORTEX_A75		0x4100d0a0
 #define ARM_CPU_PART_MASK		0xff00fff0
 
+/* Broadcom cores */
+#define ARM_CPU_PART_BRAHMA_B15		0x420000f0
+
 /* DEC implemented cores */
 #define ARM_CPU_PART_SA1100		0x4400a110
 
-- 
2.7.4
