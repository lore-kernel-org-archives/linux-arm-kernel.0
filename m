From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 19 May 2017 12:25:51 +0800
Subject: [PATCH v10 04/10] MAINTAINERS: update file entries for Coresight
 subsystem
In-Reply-To: <1495167957-14923-1-git-send-email-leo.yan@linaro.org>
References: <1495167957-14923-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1495167957-14923-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update document file entries for Coresight debug module.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b..d443258 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1208,7 +1208,9 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/hwtracing/coresight/*
 F:	Documentation/trace/coresight.txt
+F:	Documentation/trace/coresight-cpu-debug.txt
 F:	Documentation/devicetree/bindings/arm/coresight.txt
+F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	tools/perf/arch/arm/util/pmu.c
 F:	tools/perf/arch/arm/util/auxtrace.c
-- 
2.7.4
