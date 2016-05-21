From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:51:29 +0200
Subject: [PATCH 0117/1529] Fix typo
Message-ID: <20160521115129.5498-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index 4cd13ab..65e5f9c 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -423,7 +423,7 @@ void s3c2410_iotiming_set(struct s3c_cpufreq_config *cfg,
  * @timings: The IO timing information to fill out.
  *
  * Calculate the @timings timing information from the current frequency
- * information in @cfg, and the new frequency configur
+ * information in @cfg, and the new frequency configuration
  * through all the IO banks, reading the state and then updating @iot
  * as necessary.
  *
-- 
2.8.2.534.g1f66975
