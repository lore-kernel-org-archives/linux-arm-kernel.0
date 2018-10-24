From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Wed, 24 Oct 2018 11:14:29 +0000
Subject: [PATCH V1 0/3] Add flexcan support
Message-ID: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series intends to add flexcan support for IMX6 platforms.

Dong Aisheng (3):
  ARM: dts: imx6sx-sdb: Add flexcan support
  ARM: dts: imx6sx-sabreauto: Add flexcan support
  ARM: dts: sabreauto: Add flexcan support

 .../boot/dts/imx6dl-sabreauto-flexcan1.dts    | 19 +++++++
 .../arm/boot/dts/imx6q-sabreauto-flexcan1.dts | 19 +++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi      | 48 ++++++++++++++++
 arch/arm/boot/dts/imx6sx-sabreauto.dts        | 57 +++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb-reva.dts         | 12 ++++
 arch/arm/boot/dts/imx6sx-sdb.dts              |  5 ++
 arch/arm/boot/dts/imx6sx-sdb.dtsi             | 42 ++++++++++++++
 7 files changed, 202 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts

-- 
2.17.1
