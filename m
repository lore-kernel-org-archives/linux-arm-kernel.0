From: david@lechnology.com (David Lechner)
Date: Wed, 13 Apr 2016 17:30:25 -0500
Subject: [PATCH 0/3] More small davinci device tree fixes
Message-ID: <1460586628-25152-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is another set of small davinci device tree fixes.

Tested working on LEGO MINDSTORMS EV3.

David Lechner (3):
  ARM: davinci: add spi0 to da850 device tree
  ARM: davinci: disable mdio and eth0 in da850.dtsi
  ARM: davinci: da850: There are 101 interrupts.

 arch/arm/boot/dts/da850-enbw-cmc.dts |  6 ++++++
 arch/arm/boot/dts/da850.dtsi         | 14 +++++++++++++-
 arch/arm/mach-davinci/da8xx-dt.c     |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
1.9.1
