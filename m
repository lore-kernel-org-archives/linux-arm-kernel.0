From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:06 +0900
Subject: [GIT PULL] Second Round Of Renesas ARM Based SoC DT Updates For v3.18
Message-ID: <cover.1408928822.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v3.18,
which I have already sent a pull-request for.


The following changes since commit d594c9775409a4276133db5e34dbd791329c5eae:

  ARM: shmobile: lager: add VIN1/ADV7180 device nodes (2014-08-17 09:44:07 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.18

for you to fetch changes up to f170b97c9ad0b8ba3e99f02cbadc7676383fee09:

  ARM: shmobile: sh73a0 dtsi: Move interrupt-parent to the top (2014-08-22 12:34:53 +0900)

----------------------------------------------------------------
Second Round Of Renesas ARM Based SoC DT Updates For v3.18

* Tidy up interrupt-parents
* Add clocks register defines for r8a7740 SoC
* Add JPU clock to r8a7791 and r8a7790 SoCs

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: r8a7779 dtsi: Remove superfluous interrupt-parent
      ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent
      ARM: shmobile: r8a7791 dtsi: Remove superfluous interrupt-parent
      ARM: shmobile: sh73a0 dtsi: Move interrupt-parent to the top

Mikhail Ulyanov (2):
      ARM: shmobile: r8a7790: Add JPU clock dt and CPG define.
      ARM: shmobile: r8a7791: Add JPU clock dt and CPG define.

Ulrich Hecht (1):
      ARM: shmobile: r8a7740: clock register bits

 arch/arm/boot/dts/r8a7779.dtsi            |  6 ---
 arch/arm/boot/dts/r8a7790.dtsi            |  7 ++-
 arch/arm/boot/dts/r8a7791.dtsi            |  7 ++-
 arch/arm/boot/dts/sh73a0.dtsi             | 24 +---------
 include/dt-bindings/clock/r8a7740-clock.h | 77 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |  1 +
 include/dt-bindings/clock/r8a7791-clock.h |  1 +
 7 files changed, 86 insertions(+), 37 deletions(-)
 create mode 100644 include/dt-bindings/clock/r8a7740-clock.h
