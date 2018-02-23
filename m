From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Feb 2018 13:09:22 -0800
Subject: [PATCH 3/4] ARM: add Broadcom Brahma-B15 main ID definition
In-Reply-To: <20180223210923.544-1-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
Message-ID: <20180223210923.544-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define Broadcom's Brahma-B15 main ID register value, masked with
ARM_CPU_PART_MASK.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cputype.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 6d1c7b22faea..d1b62ee69f3b 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -78,6 +78,7 @@
 #define ARM_CPU_PART_MASK		0xff00fff0
 
 /* Broadcom implemented processors */
+#define ARM_CPU_PART_BRAHMA_B15		0x420000f0
 #define ARM_CPU_PART_BRAHMA_B53		0x42001000
 
 /* DEC implemented cores */
-- 
2.14.1
