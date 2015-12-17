From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 17 Dec 2015 16:50:49 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.4, 3rd round
Message-ID: <20151217085049.GA9161@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9c17190595840b4ed30e8d5f286636ceb28aae4f:

  ARM: dts: vf610: use reset values for L2 cache latencies (2015-12-11 21:32:47 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.4-3

for you to fetch changes up to 3a35e470bc6bc4ce34c19c410ebbe4e3bbf0bafe:

  ARM: dts: imx6: Fix Ethernet PHY mode on Ventana boards (2015-12-15 16:53:15 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.4, 3rd round:
- Fix Ethernet PHY mode on i.MX6 Ventana boards, which can result in
  a non-functional Ethernet when Marvell phy driver rather than generic
  phy driver is selected.
- Fix an assigned-clock configuration bug on imx6qdl-sabreauto board
  which was introduced by commit ed339363de1b ("ARM: dts:
  imx6qdl-sabreauto: Allow HDMI and LVDS to work simultaneously").

----------------------------------------------------------------
Bai Ping (1):
      ARM: dts: imx: Fix the assigned-clock mismatch issue on imx6q/dl

Krzysztof Ha?asa (1):
      ARM: dts: imx6: Fix Ethernet PHY mode on Ventana boards

 arch/arm/boot/dts/imx6q-gw5400-a.dts     | 2 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 6 +++---
 6 files changed, 8 insertions(+), 8 deletions(-)
