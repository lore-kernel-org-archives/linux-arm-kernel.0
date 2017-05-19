From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 19 May 2017 12:25:50 +0800
Subject: [PATCH v10 03/10] doc: Add coresight_cpu_debug.enable to
 kernel-parameters.txt
In-Reply-To: <1495167957-14923-1-git-send-email-leo.yan@linaro.org>
References: <1495167957-14923-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1495167957-14923-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add coresight_cpu_debug.enable to kernel-parameters.txt, this flag is
used to enable/disable the CPU sampling based debugging.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 15f79c2..ff67ad7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -649,6 +649,13 @@
 			/proc/<pid>/coredump_filter.
 			See also Documentation/filesystems/proc.txt.
 
+	coresight_cpu_debug.enable
+			[ARM,ARM64]
+			Format: <bool>
+			Enable/disable the CPU sampling based debugging.
+			0: default value, disable debugging
+			1: enable debugging at boot time
+
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
-- 
2.7.4
