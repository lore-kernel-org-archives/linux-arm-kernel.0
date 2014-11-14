From: c.hemp@phytec.de (Christian Hemp)
Date: Fri, 14 Nov 2014 14:32:21 +0100
Subject: [PATCH 0/5] ARM:dts:imx6:phyflex: dt update
Message-ID: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series updates the PHYTEC phyFLEX-i.MX6 board.
 - set nodes in correct order
 - enables gpmi in pfla02
 - sets the correct PMIC interrupt
 - add support for PCIe and CAN

Based on branch for-next from Shawn Guo:
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git

Christian Hemp (5):
  ARM:dts:imx6:phyFLEX: set nodes in alphabetical order
  ARM:dts:imx6:phyFLEX: Enable gpmi in module file
  ARM:dts:imx6:phyFLEX: Set correct interrupt for pmic
  ARM:dts:imx6:phyFLEX: Add PCIe
  ARM:dts:imx6:phyFLEX: Add CAN support

 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi |  8 +++-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 56 ++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 18 deletions(-)

-- 
1.9.1
