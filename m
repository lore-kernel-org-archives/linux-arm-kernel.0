From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Tue, 16 May 2017 15:07:20 +0300
Subject: [PATCH 0/3] arm64: dts: introduce QorIQ DPAA 1.x FMan device tree
 nodes
Message-ID: <1494936443-14869-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces the QorIQ Data Path Acceleration Arhitecture
(DPAA) Frame Manager device tree nodes for the ARM based DPAA 1.x platforms.

Madalin Bucur (3):
  arm64: dts: add DPAA FMan nodes
  arm64: dts: add LS1043A DPAA FMan support
  arm64: dts: add LS1046A DPAA FMan nodes

 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi | 45 ++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |  2 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  | 73 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 13 +++-
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi | 48 +++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |  2 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 60 ++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 11 ++-
 .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    | 42 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi    | 42 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi     | 41 +++++++++++
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   | 81 ++++++++++++++++++++++
 17 files changed, 663 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi

-- 
2.1.0
