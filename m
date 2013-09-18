From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 18 Sep 2013 17:05:20 +0200
Subject: [PATCH 0/2] pwm: atmel-tcb: config fixes
Message-ID: <1379516720-23289-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fix 2 bugs regarding the pwm configuration:
 - the clock source of the timer channel is never applied
 - the maximum time that can be represented when using the slow clock may be
   wrong if the tc block provide a 32 bits width counter

Best Regards,

Boris

Boris BREZILLON (2):
  pwm: atmel-tcb: add missing clk source config
  pwm: atmel-tcb: fix max time computation for slow clk source

 drivers/pwm/pwm-atmel-tcb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
1.7.9.5
