From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Jul 2018 11:23:44 +0100
Subject: [PATCH 0/3] Finish Armada DRM DT support
Message-ID: <20180710102344.GH17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finish Armada DRM support for DT, finally allowing mainline kernels to
use this driver unimpeded.

 arch/arm/boot/dts/dove-cubox.dts     | 43 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/armada/Makefile      |  3 +++
 drivers/gpu/drm/armada/armada_drv.c  | 29 ++++++++++++++++++---
 drivers/gpu/drm/armada/armada_rmem.c | 49 ++++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 3 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
