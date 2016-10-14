From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 14 Oct 2016 11:34:59 -0300
Subject: [PATCH 0/3] thermal: Fix module autoload for drivers
Message-ID: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small series contains trivial fixes to allow modules to be autoloaded
when its correspoinding thermal device is registered.

Best regards,
Javier


Javier Martinez Canillas (3):
  thermal: max77620: Fix module autoload
  thermal: tango: Fix module autoload
  thermal: db8500: Fix module autoload

 drivers/thermal/db8500_thermal.c   | 1 +
 drivers/thermal/max77620_thermal.c | 1 +
 drivers/thermal/tango_thermal.c    | 1 +
 3 files changed, 3 insertions(+)

-- 
2.7.4
