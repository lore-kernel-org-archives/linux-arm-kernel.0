From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 14 Jul 2014 16:12:15 +0530
Subject: [RESEND PATCH 0/8] arm: dts: dra7: Add PCIe data and PCIe PHY data
Message-ID: <1405334543-25509-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[1] is split into separate series in order for individual subsystem
Maintainers to pick up the patches. This series handles the PCIe
dt data for DRA7.

This series has better commit logs than the previous one modified as
suggested by Tero.

[1] -> https://lkml.org/lkml/2014/5/29/258

Keerthy (2):
  ARM: dts: dra7xx-clocks: Add divider table to optfclk_pciephy_div
    clock
  ARM: dts: dra7xx-clocks: Change the parent of apll_pcie_in_clk_mux to
    dpll_pcie_ref_m2ldo_ck

Kishon Vijay Abraham I (6):
  ARM: dts: dra7xx-clocks: Add missing 32KHz clocks used for PHY
  ARM: dts: dra7xx-clocks: rename pcie clocks to accommodate second PHY
    instance
  ARM: dts: dra7xx-clocks: Add missing clocks for second PCIe PHY
    instance
  ARM: dts: dra7: Add dt data for PCIe PHY control module
  ARM: dts: dra7: Add dt data for PCIe PHY
  ARM: dts: dra7: Add dt data for PCIe controller

 arch/arm/boot/dts/dra7.dtsi          |  127 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   39 ++++++++++-
 2 files changed, 163 insertions(+), 3 deletions(-)

-- 
1.7.9.5
