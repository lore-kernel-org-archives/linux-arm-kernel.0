From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  9 May 2017 10:49:57 +0800
Subject: [PATCH v9 4/9] MAINTAINERS: update file entries for Coresight
 subsystem
In-Reply-To: <1494298202-6739-1-git-send-email-leo.yan@linaro.org>
References: <1494298202-6739-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1494298202-6739-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update document file entries for Coresight debug module.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b948dfa..a4b1f60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1191,7 +1191,9 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
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
