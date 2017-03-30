From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Thu, 30 Mar 2017 17:37:49 +0300
Subject: [PATCH 0/3] introduce QorIQ DPAA 1.x QBMan device tree nodes
Message-ID: <1490884672-18294-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces the QorIQ Data Path Acceleration Arhitecture
(DPAA) Queue Manager and Buffer Manager device tree nodes for the ARM
based DPAA 1.x platforms.

Madalin Bucur (3):
  dts: arm64: add DPAA QBMan portals
  dts: arm64: add LS1043A DPAA QBMan nodes
  dts: arm64: add LS1046A DPAA QBMan nodes

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 52 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 52 +++++++++++++++
 .../boot/dts/freescale/qoriq-bman1-portals.dtsi    | 67 +++++++++++++++++++
 .../boot/dts/freescale/qoriq-qman1-portals.dtsi    | 76 ++++++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi

-- 
2.1.0
