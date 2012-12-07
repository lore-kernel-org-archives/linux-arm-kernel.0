From: anilkumar.v@ti.com (Kumar, Anil)
Date: Fri, 7 Dec 2012 15:57:29 +0530
Subject: [PATCH 0/2]  ARM: davinci: da850: add pinctrl support
Message-ID: <1354876051-25938-1-git-send-email-anilkumar.v@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds:

* Add pinctrl-single for handling Padconf registers.
* Add NAND node to export NAND functionality on da850 EVM.
* Add NAND pinctrl node to do pin mux according to pinctrl-single driver.

Kumar, Anil (2):
  ARM: davinci: da850: add pinctrl driver entries
  ARM: davinci: da850: add NAND driver entries

 .../devicetree/bindings/arm/davinci/pinctrl.txt    |   29 ++++++++++++++++++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/da850-evm.dts                    |   22 +++++++++++++++
 arch/arm/boot/dts/da850.dtsi                       |   23 +++++++++++++++
 arch/arm/configs/da8xx_omapl_defconfig             |    1 +
 5 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/pinctrl.txt

-- 
1.7.4.1
