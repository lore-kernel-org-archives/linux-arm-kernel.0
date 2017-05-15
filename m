From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Mon, 15 May 2017 12:21:15 +0300
Subject: [PATCH v2 0/3] arm64: dts: introduce QorIQ DPAA 1.x QBMan device tree
 nodes
Message-ID: <1494840078-22243-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces the QorIQ Data Path Acceleration Arhitecture
(DPAA) Queue Manager and Buffer Manager device tree nodes for the ARM
based DPAA 1.x platforms.

Changes since v1 - addressed feedback received from Shawn Guo:
 - renamed portal dtsi files
 - added required newlines
 - removed typos

Madalin Bucur (3):
  arm64: dts: add DPAA QBMan portals
  arm64: dts: add LS1043A DPAA QBMan nodes
  arm64: dts: add LS1046A DPAA QBMan nodes

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 53 ++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 54 +++++++++++++++
 .../boot/dts/freescale/qoriq-bman-portals.dtsi     | 71 +++++++++++++++++++
 .../boot/dts/freescale/qoriq-qman-portals.dtsi     | 80 ++++++++++++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi

-- 
2.1.0
