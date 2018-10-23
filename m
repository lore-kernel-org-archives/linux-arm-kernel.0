From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 24 Oct 2018 00:36:50 +0530
Subject: [PATCH 0/5] Add Pinctrl and GPIO support for HI3670 SoC
Message-ID: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds Pinctrl and GPIO support for HI3670 SoC from HiSilicon
found in the HiKey970 developement board. Also, the remaining UARTs are
enabled and GPIO line names are added based on the Schematics and the
96Boards Consumer Edition spec.

Note: These patches are based on the below common clk patches pushed
earlier:

arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
arm64: dts: hisilicon: Source SoC clock for UART6

Thanks,
Mani

Manivannan Sadhasivam (5):
  arm64: dts: hisilicon: Add Pinctrl support for HiKey970 board
  arm64: dts: hisilicon: hi3760: Add GPIO controller support
  arm64: dts: hisilicon: hi3670: Add UART nodes
  arm64: boot: dts: hisilicon: hikey970: Enable on-board UARTs
  arm64: dts: hisilicon: hikey970: Add GPIO line names

 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 338 +++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 451 ++++++++++++++++++
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 244 ++++++++++
 3 files changed, 1033 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi

-- 
2.17.1
