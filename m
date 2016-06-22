From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jun 2016 14:16:45 +0200
Subject: [PATCH] MAINTAINERS: Extend Samsung SoC entry with S3C/S5P drivers
Message-ID: <1466597805-31988-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the drivers for S3C and S5P families of Samsung SoCs go in
through Samsung SoC tree.  Extend the entry so proper maintainers would
be displayed in such cases, most notably the cpufreq drivers.  This does
not change the work-flow for other drivers which have sub-maintainers
(like Samsung clocks).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-pm at vger.kernel.org
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 092ce3990541..1e5cf07030ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1619,8 +1619,10 @@ F:	arch/arm/mach-s3c24*/
 F:	arch/arm/mach-s3c64xx/
 F:	arch/arm/mach-s5p*/
 F:	arch/arm/mach-exynos*/
-F:	drivers/*/*s3c2410*
-F:	drivers/*/*/*s3c2410*
+F:	drivers/*/*s3c24*
+F:	drivers/*/*/*s3c24*
+F:	drivers/*/*s3c64xx*
+F:	drivers/*/*s5pv210*
 F:	drivers/memory/samsung/*
 F:	drivers/soc/samsung/*
 F:	drivers/spi/spi-s3c*
-- 
1.9.1
