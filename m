From: jchandra@broadcom.com (Jayachandran C)
Date: Sat, 20 Feb 2016 19:49:23 +0530
Subject: [PATCH v2 4/5] arm64: cputype info for Broadcom Vulcan
In-Reply-To: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
References: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1455977964-8099-5-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Broadcom Vulcan implementor ID and part ID in cputype.h. This is
to document the values.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cputype.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 1a59493..3dcecdf 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -65,6 +65,7 @@
 #define ARM_CPU_IMP_ARM			0x41
 #define ARM_CPU_IMP_APM			0x50
 #define ARM_CPU_IMP_CAVIUM		0x43
+#define ARM_CPU_IMP_BRCM		0x42
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -75,6 +76,8 @@
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 
+#define BRCM_CPU_PART_VULCAN		0x516
+
 #ifndef __ASSEMBLY__
 
 /*
-- 
1.9.1
