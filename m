From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 28 Apr 2017 16:05:56 -0500
Subject: [PATCH 2/9] arm64: defconfig: enable ACPI_CPPC_CPUFREQ
In-Reply-To: <1493413563-18375-1-git-send-email-timur@codeaurora.org>
References: <1493413563-18375-1-git-send-email-timur@codeaurora.org>
Message-ID: <1493413563-18375-3-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPPC CPUFreq driver is used on many ACPI-based ARM64 server systems.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d916fc3..11f19df 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -89,6 +89,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
+CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
