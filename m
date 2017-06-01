From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Jun 2017 11:21:10 +0100
Subject: [PATCH v2 18/25] arm64: Add MIDR values for Cavium cn83XX SoCs
In-Reply-To: <20170601102117.17750-1-marc.zyngier@arm.com>
References: <20170601102117.17750-1-marc.zyngier@arm.com>
Message-ID: <20170601102117.17750-19-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 0984d1b3a8f2..235e77d98261 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -86,6 +86,7 @@
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
+#define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
 
 #define BRCM_CPU_PART_VULCAN		0x516
 
@@ -96,6 +97,7 @@
 #define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
+#define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 
 #ifndef __ASSEMBLY__
-- 
2.11.0
