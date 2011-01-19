From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 12:25:43 -0800
Subject: [PATCH v2 07/11] msm: Add MSM 8960 cpu_is check
In-Reply-To: <1295468747-22796-1-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1295468747-22796-8-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/cpu.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/cpu.h b/arch/arm/mach-msm/include/mach/cpu.h
index e1ba9db..a9481b0 100644
--- a/arch/arm/mach-msm/include/mach/cpu.h
+++ b/arch/arm/mach-msm/include/mach/cpu.h
@@ -24,6 +24,7 @@
 #define cpu_is_msm7x30()	0
 #define cpu_is_qsd8x50()	0
 #define cpu_is_msm8x60()	0
+#define cpu_is_msm8960()	0
 
 #ifdef CONFIG_ARCH_MSM7X00A
 # undef cpu_is_msm7x01
@@ -45,4 +46,9 @@
 # define cpu_is_msm8x60()	1
 #endif
 
+#ifdef CONFIG_ARCH_MSM8960
+# undef cpu_is_msm8960
+# define cpu_is_msm8960()	1
+#endif
+
 #endif
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
