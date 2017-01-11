From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 11 Jan 2017 09:41:14 -0500
Subject: [PATCH v3 1/5] arm64: Define Falkor v1 CPU
Message-ID: <20170111144118.17062-1-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shanker Donthineni <shankerd@codeaurora.org>

Define the MIDR implementer and part number field values for the Qualcomm
Datacenter Technologies Falkor processor version 1 in the usual manner.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/include/asm/cputype.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 26a68dd..ee60561 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -71,6 +71,7 @@
 #define ARM_CPU_IMP_APM			0x50
 #define ARM_CPU_IMP_CAVIUM		0x43
 #define ARM_CPU_IMP_BRCM		0x42
+#define ARM_CPU_IMP_QCOM		0x51
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -84,10 +85,13 @@
 
 #define BRCM_CPU_PART_VULCAN		0x516
 
+#define QCOM_CPU_PART_FALKOR_V1		0x800
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
+#define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 
 #ifndef __ASSEMBLY__
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.
