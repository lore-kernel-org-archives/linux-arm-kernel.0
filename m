From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon,  8 Feb 2016 14:53:00 -0300
Subject: [PATCH 0/3] ARM: omap2plus_defconfig: Enable OMAP3 ISP and
 dependencies
Message-ID: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small series enables all the Kconfig symbols needed to test the
OMAP3 ISP on the IGEPv2 board. I've enabled as much as possible as a
module and only as built-in the options that are boolean.

Best regards,
Javier


Javier Martinez Canillas (3):
  ARM: omap2plus_defconfig: Enable OMAP IOMMU support
  ARM: omap2plus_defconfig: Enable ISP support and dependencies
  ARM: omap2plus_defconfig: Enable TI TVP5150 video decoder support

 arch/arm/configs/omap2plus_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.5.0
