From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 Nov 2017 12:17:41 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Fixes for v4.15
Message-ID: <cover.1511781272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this Renesas ARM based SoC DT fix for v4.15.

It is from Arnd adding missing '#reset-cells' property to cpg nodes.
This flagged by recent dtc.

This pull request is based on
"[GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.15"
which is tagged as renesas-dt2-for-v4.15 and you have already pulled.


The following changes since commit b6d3b649441936621c87b79bff8dd436e2397e3c:

  ARM: dts: r8a7743: Add xhci support to SoC dtsi (2017-10-18 07:21:36 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes-for-v4.15

for you to fetch changes up to 098f53050154498876ef3febde706ff5c8b25cf4:

  ARM: dts: r8a779x: Add '#reset-cells' in cpg-mssr (2017-11-20 11:35:41 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Fixes for v4.15

Add missing '#reset-cells' property to cpg nodes.
This flagged by recent dtc.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: dts: r8a779x: Add '#reset-cells' in cpg-mssr

 arch/arm/boot/dts/r8a7790.dtsi | 1 +
 arch/arm/boot/dts/r8a7792.dtsi | 1 +
 arch/arm/boot/dts/r8a7793.dtsi | 1 +
 arch/arm/boot/dts/r8a7794.dtsi | 1 +
 4 files changed, 4 insertions(+)
