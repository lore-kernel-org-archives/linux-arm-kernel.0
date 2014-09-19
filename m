From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Sep 2014 13:14:13 +0900
Subject: [GIT PULL] Fifth Round of Renesas ARM Based SoC DT Updates for v3.18
Message-ID: <cover.1411099817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fifth round of Renesas ARM based SoC DT updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-dt4-for-v3.18,
which I have already sent a pull-request for.


The following changes since commit a742795be9ceae2853ca71f216193f29da151da8:

  ARM: shmobile: Initial Alt board device tree (2014-09-09 11:29:27 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt5-for-v3.18

for you to fetch changes up to 08adafd4a1f8c9b6e2c49d955a0e45743c9ffd9a:

  ARM: shmobile: Add manufacturer for KZM boards (2014-09-17 09:23:14 +0900)

----------------------------------------------------------------
Fifth Round of Renesas ARM Based SoC DT Updates for v3.18

* Document manufacturer for KZM boards
* Use SoC-specific irqc compatible property

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a73a4 dtsi: Add SoC-specific irqc compatible property
      ARM: shmobile: Add manufacturer for KZM boards

 Documentation/devicetree/bindings/arm/shmobile.txt | 6 +++---
 arch/arm/boot/dts/r8a73a4.dtsi                     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)
