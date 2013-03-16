From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 15 Mar 2013 20:09:28 -0500
Subject: [PATCH 0/3] arm: ep93xx driver cleanup
In-Reply-To: <201303151800.18192.hartleys@visionengravers.com>
References: <201303151800.18192.hartleys@visionengravers.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020980106CBE@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops... sent to the wrong list.

Please ignore.

Regards,
Hartley

-----Original Message-----
From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of H Hartley Sweeten
Sent: Friday, March 15, 2013 6:00 PM
To: ARM Kernel
Cc: Ryan Mallon
Subject: [PATCH 0/3] arm: ep93xx driver cleanup

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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
