From: nm@ti.com (Nishanth Menon)
Date: Wed, 5 Sep 2018 11:20:21 -0500
Subject: [PATCH 0/3] arm64: dts: ti: am654: Enable additional nodes
Message-ID: <20180905162024.28243-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Series based on: v4.19-rc1 + https://patchwork.kernel.org/patch/10588769/
For v4.20

Boot log: https://pastebin.ubuntu.com/p/c5XGVp85bs/ (MMC is pending).
Boot log integrated with:
	https://patchwork.kernel.org/patch/10577731/ (uart Kconfig update)
	https://patchwork.kernel.org/patch/10577723/ (message manager Kconfig update)
	https://patchwork.kernel.org/patch/10577729/ (TISCI - in linux-next)
        https://patchwork.kernel.org/patch/10577727/ (TISCI - in linux-next)
	https://patchwork.kernel.org/patch/10577721/ (TISCI Clk Kconfig update)

Nishanth Menon (3):
  arm64: dts: ti: am654: Add uart nodes
  arm64: dts: ti: am654: Add secure proxy instance for main domain
  arm64: dts: ti: k3-am6: Add Device Management Security Controller
    support

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 41 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        | 18 ++++++++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     | 46 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi            | 10 ++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts |  5 +++
 5 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi

-- 
2.15.1
