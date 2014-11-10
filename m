From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:24 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Cleanups for v3.19
Message-ID: <cover.1415582842.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT cleanups for v3.19.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-cleanups-for-v3.19,
which I have already sent a pull-request for.


The following changes since commit 120f038cf04b95dc895cba503a7516ff75561438:

  ARM: shmobile: kzm9d dts: Add chosen/stdout-path (2014-10-24 10:44:10 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-cleanups2-for-v3.19

for you to fetch changes up to 89aeff9989e87bb2d9d652994010bc18c68675d9:

  ARM: shmobile: alt dts: Drop console= bootargs parameter (2014-11-05 14:54:10 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Cleanups for v3.19

* Drop console= bootargs parameter on alt
* Correct scifb* naming on r8a73a4
* Drop 0x unit-address prefixes
* Remove unnecessary MMC options

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: r8a7790 dtsi: Drop bogus 0x unit-address prefix
      ARM: shmobile: r8a7791 dtsi: Drop bogus 0x unit-address prefix
      ARM: shmobile: kzm9g-reference dts: Drop bogus 0x unit-address prefix

Kuninori Morimoto (3):
      ARM: shmobile: r8a7778 dtsi: Remove unnecessary MMC options
      ARM: shmobile: r8a7779 dtsi: Remove unnecessary MMC options
      ARM: shmobile: r8a7790 dtsi: Remove unnecessary MMC options

Simon Horman (1):
      ARM: shmobile: alt dts: Drop console= bootargs parameter

Ulrich Hecht (1):
      ARM: shmobile: r8a73a4: fix scifb* naming

 arch/arm/boot/dts/r8a73a4.dtsi               | 8 ++++----
 arch/arm/boot/dts/r8a7778.dtsi               | 6 ------
 arch/arm/boot/dts/r8a7779.dtsi               | 8 --------
 arch/arm/boot/dts/r8a7790.dtsi               | 6 +-----
 arch/arm/boot/dts/r8a7791.dtsi               | 2 +-
 arch/arm/boot/dts/r8a7794-alt.dts            | 2 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 7 files changed, 8 insertions(+), 26 deletions(-)
