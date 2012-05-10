From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2012 11:39:19 -0700
Subject: [GIT PULL 9/10] omap devicetree updates for v3.5 merge window
In-Reply-To: <pull-1336675159-747052>
Message-ID: <mailman.15.1336675225.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b3431f5ba402a98a89b78a9408b4972d8870df4d:

  arm/dts: OMAP3: Add mmc controller nodes and board data (2012-03-14 21:54:57 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-dt-for-v3.5

for you to fetch changes up to 40364b9f5a4d167d97bb6a76cd239ca8cfff056a:

  arm/dts: omap4-panda: Add LEDs support (2012-05-09 17:18:03 -0700)

----------------------------------------------------------------
Minor DT updates based on the dt-missed-3.4 branch

----------------------------------------------------------------
Benoit Cousson (3):
      arm/dts: twl4030: Add twl4030-gpio node
      arm/dts: omap4-sdp: Add LEDs support
      arm/dts: omap4-panda: Add LEDs support

Peter Ujfalusi (2):
      OMAP4: devices: Do not create dmic device if the dtb has been provided
      OMAP4: devices: Do not create mcpdm device if the dtb has been provided

 arch/arm/boot/dts/omap4-panda.dts |   15 +++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts   |   43 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi    |    8 +++++++
 arch/arm/mach-omap2/devices.c     |    7 +++---
 4 files changed, 70 insertions(+), 3 deletions(-)
