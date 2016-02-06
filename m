From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  6 Feb 2016 22:01:07 +0000
Subject: [PATCH 0/2] ARM: bcm2835_defconfig: Enable RPi power domain driver
Message-ID: <1454796069-26830-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series allow us to enable power domains on the Raspberry Pi
in the defconfig.

This requires Stephen Warren's latest series ("ARM: bcm2835_defconfig:
rebuild on next-20160205") applied first.

Stefan Wahren (2):
  ARM: bcm2835_defconfig: Enable RPi firmware driver
  ARM: bcm2835_defconfig: Enable RPi power domain driver

 arch/arm/configs/bcm2835_defconfig |    2 ++
 1 file changed, 2 insertions(+)

-- 
1.7.9.5
