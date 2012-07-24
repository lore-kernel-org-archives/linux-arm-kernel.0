From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 24 Jul 2012 11:48:51 +0530
Subject: [PATCH v2 0/4] Add AM33XX regulators device tree data
Message-ID: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add AM33XX regulators (tps65910/tps65217) device
tree data to am335x-evm and am335x-bone dts files. These patches
are based on Tony L "devel-dt" tree and tested on AM335x EVM and
Bone devices.

Changes from v1:
	- Incorporated all Mark Brown's review comments on v1 by
	  * moving all the regulator constraints to corresponding
	    DTS file
	  * Regulator constraints are added according to board.
	- regulator name is added.

AnilKumar Ch (4):
  ARM: OMAP2+: AM33XX: Add tps65910 device tree data
  ARM: OMAP2+: AM33XX: Add tps65217 device tree data
  arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
  arm/dts: Add tps65217 regulator DT data to am335x-bone.dts

 arch/arm/boot/dts/am335x-bone.dts |   28 ++++++++++++
 arch/arm/boot/dts/am335x-evm.dts  |   28 ++++++++++++
 arch/arm/boot/dts/tps65217.dtsi   |   56 ++++++++++++++++++++++++
 arch/arm/boot/dts/tps65910.dtsi   |   86 +++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi

-- 
1.7.9.5
