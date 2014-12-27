From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 27 Dec 2014 12:00:32 +0100
Subject: [PATCH 0/3] Add Armada 385 General Purpose Development Board support
Message-ID: <1419678035-10658-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patch set adds the support for the Armada 385 GP board, this board
is pretty close to the Armada 385 RD one. It comes with a new revision
of the Armada 385 SoC (B0).

I added a patch from Maxime's serie to support the AP board to this
series.

Thanks,

Gr?gory


Gregory CLEMENT (2):
  ARM: mvebu: a38x: Add the pinctrl alias
  ARM: mvebu: Add Armada 385 General Purpose Development Board support

Maxime Ripard (1):
  ARM: mvebu: a38x: Fix node names

 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/armada-385-db.dts |   2 +-
 arch/arm/boot/dts/armada-385-gp.dts | 380 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-385-rd.dts |   2 +-
 arch/arm/boot/dts/armada-385.dtsi   |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi   |   4 +-
 6 files changed, 386 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-gp.dts

-- 
1.9.1
