From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 1 Mar 2017 17:35:03 +0200
Subject: [PATCH v2 0/2] dts: arm64: add DPAA 1 support for ARM based SoCs
Message-ID: <1488382505-17554-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DPAA 1 nodes for LS1043A/LS1046A and networking support for RDB
and QDS boards with these SoCs.

changes from v1: addressed comment from Rob Herring on using SPDX
		 license identifiers

Madalin Bucur (2):
  dts: arm64: add LS1043A DPAA support
  dts: arm64: add LS1046A DPAA support

 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi | 41 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |  2 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  | 75 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 73 +++++++++++++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi | 45 ++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |  2 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 62 +++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 66 +++++++++++++++++-
 .../boot/dts/freescale/qoriq-bman1-portals.dtsi    | 67 ++++++++++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    | 42 ++++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi    | 42 ++++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi     | 41 +++++++++++
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   | 80 ++++++++++++++++++++++
 .../boot/dts/freescale/qoriq-qman1-portals.dtsi    | 76 ++++++++++++++++++++
 19 files changed, 917 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi

-- 
2.1.0
