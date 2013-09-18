From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 18 Sep 2013 11:40:51 +0200
Subject: [GIT PULL] ARM: DTS: Fix OMAP bugs for 3.12-rc
Message-ID: <52397523.4050209@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Please pull few fixes for OMAP DTS.

Thanks,
Benoit



The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git tags/for_3.12-rc2/dts_signed

for you to fetch changes up to 775d2418f309052641d94c896f73dc779cf7ba1b:

  ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for blaze (2013-09-18 11:14:42 +0200)

----------------------------------------------------------------
Fix BBB LDO voltage to avoid HDMI destruction
Fix OMAP5 wrong attribute
Fix typo in beagle xM strings

----------------------------------------------------------------
Felipe Balbi (2):
      ARM: dts: OMAP5: fix reg property size
      ARM: dts: OMAP5: fix ocp2scp DTS data

Koen Kooi (1):
      ARM: dts: am335x-bone*: add DT for BeagleBone Black

Robert Nelson (1):
      ARM: dts: omap3-beagle-xm: fix string error in compatible property

Tony Lindgren (2):
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for pandaboard
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for blaze

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi | 262 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts         | 256 +----------------------------
 arch/arm/boot/dts/am335x-boneblack.dts    |  17 ++
 arch/arm/boot/dts/omap3-beagle-xm.dts     |   2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |  46 +++++-
 arch/arm/boot/dts/omap4-sdp.dts           |  39 ++++-
 arch/arm/boot/dts/omap5.dtsi              |   7 +-
 8 files changed, 369 insertions(+), 261 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-bone-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-boneblack.dts
