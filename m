From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 21 May 2018 12:44:24 +0100
Subject: [PATCH 01/14] ARM: add CPU part numbers for Cortex A73, A75 and
 Brahma B15
In-Reply-To: <20180521114238.GN17671@n2100.armlinux.org.uk>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
Message-ID: <E1fKjEm-00063K-Ua@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPU part numbers for the above mentioned CPUs

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cputype.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb546425da8a..adc4a3eef815 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -77,8 +77,13 @@
 #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
 #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
 #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
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
