From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 10 Oct 2012 17:35:13 +0530
Subject: [PATCH 0/3] ARM: dts: EMIF and LPDDR2 device tree data for OMAP5
 boards
Message-ID: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1:
	Renaming elpida_ecb240abacn.dtsi as lpddr2_data.dtsi
Patch 2:
	Correcting size of memory defined for omap5
Patch 3:
	EMIF and LPDDR2 device tree data for OMAP5 boards

Testing:
- Boot tested on omap5-sevm board
- Built emif as a module

Lokesh Vutla (3):
  ARM: dts: Renaming elpida_ecb240abacn.dts as lpddr2_data.dtsi
  ARM: dts: Correcting size of memory defined for omap5
  ARM: dts: EMIF and LPDDR2 device tree data for OMAP5 boards

 arch/arm/boot/dts/elpida_ecb240abacn.dtsi |   67 ---------------
 arch/arm/boot/dts/lpddr2_data.dtsi        |  129 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts         |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts           |    2 +-
 arch/arm/boot/dts/omap5-evm.dts           |   13 ++-
 arch/arm/boot/dts/omap5.dtsi              |   18 ++++
 6 files changed, 161 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi
 create mode 100644 arch/arm/boot/dts/lpddr2_data.dtsi

-- 
1.7.10.4
