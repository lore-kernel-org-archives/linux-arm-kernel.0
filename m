From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Jul 2016 11:39:35 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Fixes for v4.8
Message-ID: <cover.1468808109.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT fixes for v4.8.

This fixes some problems with clock descriptions in DT for the r8a7792 SoC
which is new in v4.8.

This pull request is based on "Second Round of Renesas ARM Based SoC DT
Updates for v4.8", tagged as renesas-dt2-for-v4.8, which you have already
pulled.


The following changes since commit 8fd763c75c3ab8e72e5d7f0d4c53531e6ff76197:

  ARM: dts: r8a7792: add SMP support (2016-06-30 14:26:14 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes-for-v4.8

for you to fetch changes up to e0c3f92a08f3e0a95024d0d032564fdc1ee96f54:

  ARM: dts: r8a7792: remove ADSP clock (2016-07-15 13:22:45 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Fixes for v4.8

* Corrections to r8a7792

----------------------------------------------------------------
Sergei Shtylyov (2):
      ARM: dts: r8a7792: add PLL1 divided by 2 clock
      ARM: dts: r8a7792: remove ADSP clock

 arch/arm/boot/dts/r8a7792.dtsi            | 9 ++++++++-
 include/dt-bindings/clock/r8a7792-clock.h | 1 -
 2 files changed, 8 insertions(+), 2 deletions(-)
