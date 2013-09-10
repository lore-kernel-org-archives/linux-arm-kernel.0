From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:17 +0100
Subject: [PATCH 16/38] iio: magn: st: Append _magn to magnetometer sensor
 device names
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of ST's sensors are appended with their sensor type and some
are not. For consistency we're extending the same naming convention
throughout.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/st_magn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 694e33e..f185720 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -16,7 +16,7 @@
 
 #define LSM303DLHC_MAGN_DEV_NAME	"lsm303dlhc_magn"
 #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
-#define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
+#define LIS3MDL_MAGN_DEV_NAME		"lis3mdl_magn"
 
 int st_magn_common_probe(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata);
-- 
1.8.1.2
