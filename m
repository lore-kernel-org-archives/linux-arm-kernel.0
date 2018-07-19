From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Jul 2018 00:47:47 -0700
Subject: [GIT PULL] few new beaglebone variants for v4.19 merge window
Message-ID: <pull-1531986403-289188@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 792f98677d7f777a4f58e567b5b0578191cb986a:

  Merge commit '949bdcc8a97c' into omap-for-v4.19/dt (2018-07-11 05:54:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/dt-pt2-signed

for you to fetch changes up to 91f6278bfa3966529c61808bd3cb8f05d7ed5dc6:

  ARM: dts: am335x: add am335x-sancloud-bbe board support (2018-07-17 01:05:37 -0700)

----------------------------------------------------------------
Few more beaglebone variants for v4.19 merge window

This adds dts files for two new beaglebone variants for
Octavo Systems OSD3358-SM-RED and Sancloud am335x-sancloud-bbe.

----------------------------------------------------------------
Koen Kooi (2):
      dt-bindings: Add vendor prefix for Sancloud
      ARM: dts: am335x: add am335x-sancloud-bbe board support

Neeraj Dantu (1):
      ARM: dts: Add DT support for Octavo Systems OSD3358-SM-RED based on TI AM335x

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts        | 457 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          | 136 ++++++
 4 files changed, 597 insertions(+), 1 deletion(-)
 create mode 100755 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
 create mode 100644 arch/arm/boot/dts/am335x-sancloud-bbe.dts
