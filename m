From: rogerq@ti.com (Roger Quadros)
Date: Thu, 13 Jun 2013 15:53:15 +0300
Subject: [PATCH v4 0/2] ARM: dts: Add USB host support for Beagle-xm
Message-ID: <1371127997-8089-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds USB host support for Beagle-xm.

Roger Quadros (2):
  ARM: dts: omap3-beagle-xm: Add USB Host support
  ARM: dts: omap3-beagle: Make USB host pin naming consistent

 arch/arm/boot/dts/omap3-beagle-xm.dts |   61 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts    |   24 ++++++------
 2 files changed, 73 insertions(+), 12 deletions(-)

-- 
1.7.4.1
