From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:08:17 +0100
Subject: [PATCH v3 00/13] Various Armada 375 DT warning fixup
Message-ID: <20161117230830.31047-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In this third version as request by Rob Herring I removed the '_' sign
in the unit address. I also added a comment in the device tree files
explaining how this unit address was composed.

Gregory

Gregory CLEMENT (13):
  ARM: dts: armada-375: Add node labels
  ARM: dts: armada-375: Use the node labels
  ARM: dts: armada-375: Fixup mdio DT warning
  ARM: dts: armada-375: Fixup bootrom DT warning
  ARM: dts: armada-375: Fixup devbus DT warning
  ARM: dts: armada-375: Fixup sa-ram DT warning
  ARM: dts: armada-375: Fixup pcie DT warnings
  ARM: dts: armada-375: Fixup pinctrl DT warnings
  ARM: dts: armada-375: Fixup soc DT warning
  ARM: dts: armada-375: Fixup internal-regs DT warning
  ARM: dts: armada-375: Remove skeleton.dtsi
  ARM: dts: armada-375: Fixup memory DT warning
  ARM: dts: armada-375: Fixup ethernet child DT warning

 arch/arm/boot/dts/armada-375-db.dts | 277 ++++++++++++++++++------------------
 arch/arm/boot/dts/armada-375.dtsi   | 102 ++++++++-----
 2 files changed, 205 insertions(+), 174 deletions(-)

-- 
2.10.2
