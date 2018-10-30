From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Tue, 30 Oct 2018 08:42:33 +0000
Subject: [PATCH V2 0/3] ARM: dts: sabreauto: Add flexcan support
Message-ID: <20181030083954.26440-1-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series intends to add flexcan support for IMX6 platforms.

ChangeLog:
V1-V2:
 *using SPDX tag for new files and remove pinctrl-assert-gpios property.

Dong Aisheng (3):
  ARM: dts: imx6sx-sdb: Add flexcan support
  ARM: dts: imx6sx-sabreauto: Add flexcan support
  ARM: dts: sabreauto: Add flexcan support

 .../boot/dts/imx6dl-sabreauto-flexcan1.dts    | 14 +++++
 .../arm/boot/dts/imx6q-sabreauto-flexcan1.dts | 14 +++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi      | 47 +++++++++++++++
 arch/arm/boot/dts/imx6sx-sabreauto.dts        | 57 +++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb-reva.dts         | 12 ++++
 arch/arm/boot/dts/imx6sx-sdb.dts              |  5 ++
 arch/arm/boot/dts/imx6sx-sdb.dtsi             | 42 ++++++++++++++
 7 files changed, 191 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts

-- 
2.17.1
