From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 20 Jul 2012 12:16:25 +0530
Subject: [PATCH 0/4] Add AM33XX regulators device tree data
Message-ID: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add AM33XX regulators (tps65910/tps65217) device
tree data to am335x-evm and am335x-bone dts files. These patches
are based on Tony L "devel-dt" tree and tested on AM335x EVM and
Bone devices.

Resending patch 1 & 2 to group all the regulator DT data files.

AnilKumar Ch (4):
  ARM: OMAP2+: AM33XX: Add tps65910 device tree data
  ARM: OMAP2+: AM33XX: Add tps65217 device tree data
  arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
  arm/dts: Add tps65217 regulator DT data to am335x-bone.dts

 arch/arm/boot/dts/am335x-bone.dts |   10 +++
 arch/arm/boot/dts/am335x-evm.dts  |   10 +++
 arch/arm/boot/dts/tps65217.dtsi   |   84 +++++++++++++++++++++++++
 arch/arm/boot/dts/tps65910.dtsi   |  123 +++++++++++++++++++++++++++++++++++++
 4 files changed, 227 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi
