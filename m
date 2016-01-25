From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 25 Jan 2016 11:37:14 -0300
Subject: [PATCH 0/2] regulator: mt6397: Add platform and OF tables and fix
 module autoload
Message-ID: <1453732637-20415-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

This small series add missing platform device and OF tables to the mt6397
regulator driver. I noticed these when reviewing a new regulator driver
that was posted since the submitted driver had the same issues [0].

The patches were just built tested so testing on an actual HW will be highly
appreciated.

[0]: https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1058808.html

Best regards,
Javier


Javier Martinez Canillas (2):
  regulator: mt6397: Add platform device ID table
  regulator: mt6397: Add OF match table

 drivers/regulator/mt6397-regulator.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.5.0
