From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon,  7 Sep 2015 18:57:45 +0200
Subject: [PATCH 0/4] ARM: dts: update Boundary Devices boards support
Message-ID: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a follow-up to the previous series that added LCD display
support.
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/364425.html

This one aims at adding touchscreen and WiFi support for Nitrogen6x as well as
adding two boards: Nitrogen6_Max and Nit6xlite.

The series has been tested against linux-next tag next-20150903.

Regards,
Gary

Gary Bisson (4):
  ARM: dts: imx6dql-nitrogen6x: add touchscreen support
  ARM: dts: imx6qdl-nitrogen6x: add wifi wl1271 support
  ARM: dts: imx: add Boundary Devices Nitrogen6_Max board
  ARM: dts: imx: add Boundary Devices Nitrogen6_Lite board

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-nit6xlite.dts             |  21 ++
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts          |  25 ++
 ...6qdl-nitrogen6x.dtsi => imx6qdl-nit6xlite.dtsi} | 419 +++++++++++----------
 ...-nitrogen6x.dtsi => imx6qdl-nitrogen6_max.dtsi} | 388 ++++++++++++++++---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  71 ++++
 6 files changed, 666 insertions(+), 260 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-nit6xlite.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6_max.dts
 copy arch/arm/boot/dts/{imx6qdl-nitrogen6x.dtsi => imx6qdl-nit6xlite.dtsi} (60%)
 copy arch/arm/boot/dts/{imx6qdl-nitrogen6x.dtsi => imx6qdl-nitrogen6_max.dtsi} (60%)

-- 
2.5.1
