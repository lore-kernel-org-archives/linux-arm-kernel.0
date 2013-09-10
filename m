From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:18 +0100
Subject: [PATCH 17/38] iio: press: st: Append _press to pressure sensor device
 names
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of ST's sensors are appended with their sensor type and some
are not. For consistency we're extending the same naming convention
throughout.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/pressure/st_pressure.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index b0b6306..f1bebce 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <linux/iio/common/st_sensors.h>
 
-#define LPS331AP_PRESS_DEV_NAME		"lps331ap"
+#define LPS331AP_PRESS_DEV_NAME		"lps331ap_press"
 
 /**
  * struct st_sensors_platform_data - default press platform data
-- 
1.8.1.2
