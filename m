From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:04:46 +0900
Subject: [GIT PULL 0/3] Second Round of Renesas ARM Based SoC DT Updates for
 v3.15
Message-ID: <cover.1392275963.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider this second round of Renesas ARM based SoC DT updates for
v3.15.

This pull request is based on the first round of such updates, tagged as
renesas-dt-for-v3.15, which I have previously sent a pull-request for.


The following changes since commit 1f4c745b2c5a083c49dc11d2f0827d9a381f1ee1:

  ARM: shmobile: r8a7790: Replace IRQ type numerical values with macros (2014-02-04 10:17:00 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.15

for you to fetch changes up to e02ee513eed4bb780848a5cedbd4b39afb395d3e:

  ARM: shmobile: koelsch dts: Add QSPI nodes (2014-02-06 20:36:12 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v3.15

r8a7791 (R-Car M2) based Koelsch board
- Add QSPI nodes

r7s72100 (RZ/A1H) SoC
- Add RSPI nodes

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
      ARM: shmobile: r8a7791 dtsi: Add QSPI node
      ARM: shmobile: koelsch dts: Add QSPI nodes

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |  2 +-
 arch/arm/boot/dts/r7s72100.dtsi                 | 75 +++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts           | 36 ++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi                  | 12 ++++
 4 files changed, 124 insertions(+), 1 deletion(-)
