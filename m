From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 Aug 2017 14:41:08 +0100
Subject: [PATCH  0/5] Add USB2.0 Host support
Message-ID: <1504100473-5528-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series aims to add USB2.0 Host support on iWave RZ/G1M(r8a7743)
based board.

This series has been tested against renesas-dev tag 20170830-v4.13-rc7

This patch has documentation dependency on below patches
 * PCI: rcar: Add r8a7743/5 support
https://patchwork.kernel.org/patch/9919697/
 * phy: rcar-gen2: Add r8a7743/5 support
https://patchwork.kernel.org/patch/9919727/

Biju Das (5):
  ARM: dts: r8a7743: Add internal PCI bridge nodes
  ARM: dts: r8a7743: Add USB PHY DT support
  ARM: dts: r8a7743: Link PCI USB devices to USB PHY
  ARM: dts: iwg20d-q7: Enable internal PCI
  ARM: dts: iwg20d-q7: Enable USB PHY

 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 26 ++++++++++
 arch/arm/boot/dts/r8a7743.dtsi          | 92 +++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

-- 
1.9.1
