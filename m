From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Jun 2017 14:15:12 -0600
Subject: [PATCH 11/17] doc: Add coresight_cpu_debug.enable to
 kernel-parameters.txt
In-Reply-To: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1496693718-9191-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Add coresight_cpu_debug.enable to kernel-parameters.txt, this flag is
used to enable/disable the CPU sampling based debugging.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 15f79c27748d..ff67ad7d2c55 100644
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
