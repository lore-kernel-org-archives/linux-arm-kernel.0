From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:01 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Timers Updates
 for v3.18
Message-ID: <cover.1410396171.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT timers updates for v3.18.

This pull request is based on a merge of:

* The previous round of DT time updates for v3.18,
  tagged as renesas-dt-timers-for-v3.18,
  which you have already merged.

* Renesas ARM Based SoC r8a7740 Multiplatform Updates for v3.18,
  tagged as renesas-r8a7740-ccf-and-timers-for-v3.18,
  which you have previously pulled.


The following changes since commit dcc683aba83cd8db964a9a1d4582d4829d6efcb2:

  Merge tag 'renesas-r8a7740-ccf-and-timers-for-v3.18' into dt-timers-for-v3.18 (2014-09-09 11:50:00 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-timers2-for-v3.18

for you to fetch changes up to 48a0d1e07d99ecfd1e5922dd22986d5813f17207:

  ARM: shmobile: kzm9g-reference: Enable CMT1 in device tree (2014-09-09 11:53:14 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Timers Updates for v3.18

* kzm9g-reference: Enable CMT1 in device tree
* Use SoC-specific timer compat strings

----------------------------------------------------------------
Simon Horman (5):
      ARM: shmobile: r8a7790: Use SoC-specific 48-bit CMT compat string
      ARM: shmobile: r7s72100: Use SoC-specific MTU2 compat string
      ARM: shmobile: r8a7791: Use SoC-specific 48-bit CMT compat string
      ARM: shmobile: r8a7779: Use SoC-specific TMU compat string
      ARM: shmobile: r8a7740: Use SoC-specific 48-bit CMT compat string

Ulrich Hecht (2):
      ARM: shmobile: sh73a0: Add CMT1 device to DT
      ARM: shmobile: kzm9g-reference: Enable CMT1 in device tree

 arch/arm/boot/dts/r7s72100.dtsi              |  2 +-
 arch/arm/boot/dts/r8a7740.dtsi               |  2 +-
 arch/arm/boot/dts/r8a7779.dtsi               |  6 +++---
 arch/arm/boot/dts/r8a7790.dtsi               |  4 ++--
 arch/arm/boot/dts/r8a7791.dtsi               |  4 ++--
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |  4 ++++
 arch/arm/boot/dts/sh73a0.dtsi                | 10 ++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c        | 11 +----------
 8 files changed, 24 insertions(+), 19 deletions(-)
