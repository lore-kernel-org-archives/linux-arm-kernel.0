From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue,  1 Dec 2015 22:55:38 +0000
Subject: [PATCH 0/3] pwm: bcm2835: improve clock handling
Message-ID: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the upcoming PWM clock support the pwm-bcm2835 should take
more care about the clock handling. But this patch series doesn't
depend on these clock driver changes.

Stefan Wahren (3):
  pwm: bcm2835: calculate scaler in pwm_config
  pwm: bcm2835: prevent division by zero
  pwm: bcm2835: fix email address specifiction

 drivers/pwm/pwm-bcm2835.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
1.7.9.5
