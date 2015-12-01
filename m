From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue,  1 Dec 2015 22:55:41 +0000
Subject: [PATCH 3/3] pwm: bcm2835: fix email address specifiction
In-Reply-To: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1449010541-3767-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pwm/pwm-bcm2835.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 31a6992..c5dbf16 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -206,6 +206,6 @@ static struct platform_driver bcm2835_pwm_driver = {
 };
 module_platform_driver(bcm2835_pwm_driver);
 
-MODULE_AUTHOR("Bart Tanghe <bart.tanghe at thomasmore.be");
+MODULE_AUTHOR("Bart Tanghe <bart.tanghe@thomasmore.be>");
 MODULE_DESCRIPTION("Broadcom BCM2835 PWM driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
