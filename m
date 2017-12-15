From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 15 Dec 2017 09:44:59 -0700
Subject: [PATCH 10/10] MAINTAINERS: Adding entry for CoreSight trace decoding
In-Reply-To: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
References: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1513356299-26274-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tor Jeremiassen <tor@ti.com>

Adding maintainers for Coresight trace decoding via perf tools.

Signed-off-by: Tor Jeremiassen <tor@ti.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82ad0eabce4f..865847aa84bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1313,7 +1313,8 @@ F:	tools/perf/arch/arm/util/pmu.c
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
-F:	tools/perf/util/cs-etm.h
+F:	tools/perf/util/cs-etm.*
+F:	tools/perf/util/cs-etm-decoder/*
 
 ARM/CORGI MACHINE SUPPORT
 M:	Richard Purdie <rpurdie@rpsys.net>
-- 
2.7.4
