From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 11 Jun 2018 10:15:08 -0600
Subject: [PATCH] Documentation: Fix reference to stm.txt
Message-ID: <1528733708-9999-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "1606f8d8e75b trace doc: convert trace/stm.txt to rst format"
changed stm.txt to stm.rst but references to it in other files have not
been modified, something that is corrected in this patch.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 2 +-
 Documentation/trace/intel_th.rst  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 1d74ad0202b6..efbc832146e7 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -426,5 +426,5 @@ root at genericarmv8:~#
 Details on how to use the generic STM API can be found here [2].
 
 [1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
-[2]. Documentation/trace/stm.txt
+[2]. Documentation/trace/stm.rst
 [3]. https://github.com/Linaro/perf-opencsd
diff --git a/Documentation/trace/intel_th.rst b/Documentation/trace/intel_th.rst
index 990f13265178..fdb34114ee20 100644
--- a/Documentation/trace/intel_th.rst
+++ b/Documentation/trace/intel_th.rst
@@ -38,7 +38,7 @@ description is at Documentation/ABI/testing/sysfs-bus-intel_th-devices-gth.
 
 STH registers an stm class device, through which it provides interface
 to userspace and kernelspace software trace sources. See
-Documentation/trace/stm.txt for more information on that.
+Documentation/trace/stm.rst for more information on that.
 
 MSU can be configured to collect trace data into a system memory
 buffer, which can later on be read from its device nodes via read() or
@@ -89,7 +89,7 @@ Quick example
 
 	$ echo 1 > /sys/bus/intel_th/devices/0-msc0/active
 
-# .. send data to master 33, see stm.txt for more details ..
+# .. send data to master 33, see stm.rst for more details ..
 # .. wait for traces to pile up ..
 # .. and stop the trace::
 
-- 
2.7.4
