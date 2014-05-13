From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 13 May 2014 17:03:28 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Clock Updates for
 v3.16
Message-ID: <cover.1399967342.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of
Renesas ARM based SoC clock updates for v3.16.

This pull request is based on the previous round of
such requests, tagged as renesas-clock-for-v3.16,
which you have already pulled.


The following changes since commit 932616eed0308cbebbb20a079e4bed3674bf1117:

  ARM: shmobile: r8a7790: remove old style audio clock (2014-04-14 12:49:43 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock2-for-v3.16

for you to fetch changes up to a505daa501dc3f02b08d0b48b049bce719299b74:

  ARM: shmobile: r8a7791: Correct SYS-DMAC clock defines (2014-05-13 10:16:42 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Clock Updates for v3.16

r8a7791 (R-Car M2) SoC
* Correct SYS-DMAC clock defines

r8a7740 (R-Mobile A1) SoC
* Correct name of DT Ethernet clock

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a7740: Correct name of DT Ethernet clock
      ARM: shmobile: r8a7791: Correct SYS-DMAC clock defines

 arch/arm/mach-shmobile/clock-r8a7740.c    | 2 +-
 include/dt-bindings/clock/r8a7791-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)
