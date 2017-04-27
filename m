From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Thu, 27 Apr 2017 17:16:22 +0530
Subject: [PATCH 1/3] arm64: Add MIDR values for Cavium cn99xx SoCs
In-Reply-To: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1493293584-20287-2-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geetha <gakula@cavium.com>

Add MIDR values for Cavium cn99xx SoCs

Signed-off-by: Geetha <gakula@cavium.com>
---
 arch/arm64/include/asm/cputype.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index fc50271..066fad0 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -85,6 +85,7 @@
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
+#define CAVIUM_CPU_PART_THUNDERX_99XX	0x0AF
 
 #define BRCM_CPU_PART_VULCAN		0x516
 
@@ -94,6 +95,8 @@
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
+#define MIDR_THUNDERX_99XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_99XX)
+#define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 
 #ifndef __ASSEMBLY__
-- 
1.9.1
