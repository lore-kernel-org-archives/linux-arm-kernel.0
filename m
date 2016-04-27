From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Apr 2016 09:08:06 +1000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.7
Message-ID: <cover.1461798352.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.7.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.7,
which you have already pulled.


The following changes since commit 6f92cb2f454c26d9bdada902e22af4bc361a5202:

  ARM: dts: gose: Enable SDHI controllers (2016-04-25 14:10:11 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.7

for you to fetch changes up to c9006ac628ca30dd0d06dad47677d338e243bb95:

  ARM: dts: r8a7794: Don't disable referenced optional clocks (2016-04-27 11:37:01 +1000)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.7

* Don't disable referenced optional clocks in DT of R-Car Gen 1 & 2 SoCs

----------------------------------------------------------------
Geert Uytterhoeven (5):
      ARM: dts: r8a7778: Don't disable referenced optional clocks
      ARM: dts: r8a7779: Don't disable referenced optional clocks
      ARM: dts: r8a7790: Don't disable referenced optional clocks
      ARM: dts: r8a7793: Don't disable referenced optional clocks
      ARM: dts: r8a7794: Don't disable referenced optional clocks

 arch/arm/boot/dts/r8a7778.dtsi | 1 -
 arch/arm/boot/dts/r8a7779.dtsi | 1 -
 arch/arm/boot/dts/r8a7790.dtsi | 5 +----
 arch/arm/boot/dts/r8a7793.dtsi | 2 --
 arch/arm/boot/dts/r8a7794.dtsi | 2 --
 5 files changed, 1 insertion(+), 10 deletions(-)
