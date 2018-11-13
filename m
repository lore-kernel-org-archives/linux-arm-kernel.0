From: vigneshr@ti.com (Vignesh R)
Date: Tue, 13 Nov 2018 11:31:07 +0530
Subject: [PATCH v2 0/4] AM654: Add pinmux support
Message-ID: <20181113060111.16374-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux definitions and pinctrl regions for AM654 SoCs
and enable uart and i2c.

v2:
Add only minimum needed macros in dt-bindings include file
New patches to illustrate pinmux using uart and i2c


Tero Kristo (1):
  arm64: dts: ti: k3-am65: Add pinctrl regions

Vignesh R (3):
  dt-bindings: pinctrl: k3: Introduce pinmux definitions
  arm64: dts: ti: am654-base-board: Add pinmux for main uart0
  arm64: dts: ti: k3-am654-base-board: Add I2C nodes

 MAINTAINERS                                   |  1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 60 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 11 +++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    | 19 ++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi           |  7 ++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 86 +++++++++++++++++++
 include/dt-bindings/pinctrl/k3.h              | 35 ++++++++
 7 files changed, 219 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/k3.h

-- 
2.19.1
