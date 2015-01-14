From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 14 Jan 2015 15:36:36 +0800
Subject: [PATCH 0/2] ARM: imx6sx-sdb: add revb board
Message-ID: <1421220998-3491-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

The imx6sx-sdb board has two revisions, the current mainline is the
reva which is used by internal user mainly, and the revb is used widely
for internal and external users.

The main changes between reva and revb board:
- cpu operating point and related voltage
- pfuse
- qspi
- can transceiver (not mainlined)

Peter Chen (2):
  ARM: imx6sx-sdb: change default board as reva board
  ARM: imx6sx-sdb: add revb board

 arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 158 +++++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb-revb.dts              | 145 +++++++++++++++++++
 .../boot/dts/{imx6sx-sdb.dts => imx6sx-sdb.dtsi}   | 131 -----------------
 3 files changed, 303 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-reva.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-revb.dts
 rename arch/arm/boot/dts/{imx6sx-sdb.dts => imx6sx-sdb.dtsi} (83%)

-- 
1.9.1
