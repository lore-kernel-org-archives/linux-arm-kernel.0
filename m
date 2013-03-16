From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 15 Mar 2013 18:00:18 -0700
Subject: [PATCH 0/3] arm: ep93xx driver cleanup
Message-ID: <201303151800.18192.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a couple section mismatch warnings and convert two of the ep93xx
drivers to use module_platform_driver.

H Hartley Sweeten (3):
  backlight: ep93xx_bl: fix section mismatch
  video: ep93xx-fb.c: fix section mismatch and use module_platform_driver
  video: ep93xx_pwm.c: fix section mismatch and use module_platform_driver

 drivers/misc/ep93xx_pwm.c           | 21 +++++----------------
 drivers/video/backlight/ep93xx_bl.c |  3 +--
 drivers/video/ep93xx-fb.c           | 18 +++---------------
 3 files changed, 9 insertions(+), 33 deletions(-)

-- 
1.8.1.4
