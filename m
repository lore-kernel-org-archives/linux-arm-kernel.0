From: muhammadabdul.wahab@centralesupelec.fr (Muhammad Abdul WAHAB)
Date: Wed, 5 Oct 2016 13:41:20 +0200
Subject: [PATCH] indentation fix (extra space removed)
Message-ID: <0b897b22-fc32-c97e-b678-1c0040782a62@centralesupelec.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An extra space is removed.

Signed-off-by: Muhammad Abdul Wahab <muhammadabdul.wahab@centralesupelec.fr>
---
  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c 
b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index e9b0719..5ea0909 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -146,7 +146,7 @@ static ssize_t mode_store(struct device *dev,
  			goto err_unlock;
  		}
  		config->ctrl |= ETMCR_STALL_MODE;
-	 } else
+	} else
  		config->ctrl &= ~ETMCR_STALL_MODE;

  	if (config->mode & ETM_MODE_TIMESTAMP) {
-- 
1.9.1
