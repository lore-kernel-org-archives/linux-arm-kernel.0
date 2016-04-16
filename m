From: david@lechnology.com (David Lechner)
Date: Sat, 16 Apr 2016 12:00:16 -0500
Subject: [PATCH v2 0/4] More small davinci device tree fixes
Message-ID: <1460826020-1256-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split "ARM: davinci: add spi0 to da850 device tree" into two patches and added
pinmux device tree nodes.

David Lechner (4):
  ARM: DTS: da850: add spi0 to device tree
  ARM: davinci: Add spi0 lookup to da8xx-dt for clock matching
  ARM: davinci: disable mdio and eth0 in da850.dtsi
  ARM: davinci: da850: There are 101 interrupts.

 arch/arm/boot/dts/da850-enbw-cmc.dts |  6 ++++++
 arch/arm/boot/dts/da850.dtsi         | 28 ++++++++++++++++++++++++++--
 arch/arm/mach-davinci/da8xx-dt.c     |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

-- 
1.9.1
