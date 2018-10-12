From: colin.king@canonical.com (Colin King)
Date: Fri, 12 Oct 2018 15:48:32 +0100
Subject: [PATCH] [media] exynos4-is: fix spelling mistake ACTURATOR -> ACTUATOR
Message-ID: <20181012144832.20722-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in macro name and text string
ERROR_SENSOR_ACTURATOR_INIT_FAIL -> ERROR_SENSOR_ACTUATOR_INIT_FAIL

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/platform/exynos4-is/fimc-is-errno.c | 4 ++--
 drivers/media/platform/exynos4-is/fimc-is-errno.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is-errno.c b/drivers/media/platform/exynos4-is/fimc-is-errno.c
index e050e63fe358..bbb08576492e 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-errno.c
+++ b/drivers/media/platform/exynos4-is/fimc-is-errno.c
@@ -90,8 +90,8 @@ const char *fimc_is_param_strerr(unsigned int error)
 		return "ERROR_SENSOR_INVALID_SIZE";
 	case ERROR_SENSOR_INVALID_SETTING:
 		return "ERROR_SENSOR_INVALID_SETTING";
-	case ERROR_SENSOR_ACTURATOR_INIT_FAIL:
-		return "ERROR_SENSOR_ACTURATOR_INIT_FAIL";
+	case ERROR_SENSOR_ACTUATOR_INIT_FAIL:
+		return "ERROR_SENSOR_ACTUATOR_INIT_FAIL";
 	case ERROR_SENSOR_INVALID_AF_POS:
 		return "ERROR_SENSOR_INVALID_AF_POS";
 	case ERROR_SENSOR_UNSUPPORT_FUNC:
diff --git a/drivers/media/platform/exynos4-is/fimc-is-errno.h b/drivers/media/platform/exynos4-is/fimc-is-errno.h
index ef981e74513a..77f4fc860be5 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-errno.h
+++ b/drivers/media/platform/exynos4-is/fimc-is-errno.h
@@ -189,7 +189,7 @@ enum fimc_is_error {
 	ERROR_SENSOR_INVALID_EXPOSURETIME,
 	ERROR_SENSOR_INVALID_SIZE,
 	ERROR_SENSOR_INVALID_SETTING,
-	ERROR_SENSOR_ACTURATOR_INIT_FAIL,
+	ERROR_SENSOR_ACTUATOR_INIT_FAIL,
 	ERROR_SENSOR_INVALID_AF_POS,
 	ERROR_SENSOR_UNSUPPORT_FUNC,
 	ERROR_SENSOR_UNSUPPORT_PERI,
-- 
2.17.1
