From: rogerq@ti.com (Roger Quadros)
Date: Thu, 20 Jun 2013 15:46:12 +0300
Subject: [PATCH v5 0/2] ARM: dts: Add USB host support for Beagle-xm
Message-ID: <1371732374-27191-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

Patch 1 adds USB host support for beagle-XM.
Patch 2 cleans up pin comments for USB host pins.

Changes in v4:
- Rebased to todays for_3.11/dts branch
- added disclaimer about temporary usage of regulator framework for
GPIO RESET lines.

cheers,
-roger

Roger Quadros (2):
  ARM: dts: omap3-beagle-xm: Add USB Host support
  ARM: dts: omap3-beagle: Make USB host pin naming consistent

 arch/arm/boot/dts/omap3-beagle-xm.dts |   81 +++++++++++++++++++++++++++++----
 arch/arm/boot/dts/omap3-beagle.dts    |   29 +++++++-----
 2 files changed, 89 insertions(+), 21 deletions(-)

-- 
1.7.4.1
