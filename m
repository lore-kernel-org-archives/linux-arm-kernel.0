From: vigneshr@ti.com (Vignesh R)
Date: Thu, 8 Nov 2018 16:56:45 +0530
Subject: [PATCH 0/2] AM654: Add pinmux support
Message-ID: <20181108112647.7205-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux definitions and pinctrl regions for AM654 SoCs

Tero Kristo (2):
  dt-bindings: pinctrl: k3-am6: Introduce pinmux definitions
  arm64: dts: ti: k3-am65: Add pinctrl regions

 MAINTAINERS                                |  1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 16 +++++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi |  8 ++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi        |  1 +
 include/dt-bindings/pinctrl/k3-am6.h       | 49 ++++++++++++++++++++++
 5 files changed, 75 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/k3-am6.h

-- 
2.19.1
