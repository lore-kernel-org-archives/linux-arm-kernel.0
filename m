From: niklas.cassel@axis.com (Niklas Cassel)
Date: Wed, 21 Feb 2018 09:59:52 +0100
Subject: [PATCH v2 0/8] ARTPEC-6 ARM SoC device tree updates
Message-ID: <20180221090000.18091-1-niklas.cassel@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here comes some ARTPEC-6 ARM SoC device tree updates.

Regards,
Niklas

Niklas Cassel (8):
  ARM: dts: artpec: disable Accelerator Coherency Port
  ARM: dts: artpec: use 1 GiB RAM
  ARM: dts: artpec: remove 0x prefix from clkctrl unit address
  ARM: dts: artpec: migrate ethernet to stmmac binding
  ARM: dts: artpec: add and utilize artpec6 pin controller
  ARM: dts: artpec: add and utilize nbpfaxi DMA controllers
  ARM: dts: artpec: add disabled node for PCIe endpoint mode
  ARM: dts: artpec: add node for hardware crypto accelerator

 arch/arm/boot/dts/artpec6-devboard.dts |   3 +-
 arch/arm/boot/dts/artpec6.dtsi         | 163 +++++++++++++++++++++++++++++++--
 2 files changed, 155 insertions(+), 11 deletions(-)

-- 
2.14.2
