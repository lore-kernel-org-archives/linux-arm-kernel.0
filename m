From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:02 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT SCIF Updates for v3.16
Message-ID: <cover.1400201670.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT SCIF updates for v3.16.

This pull request is based on Renesas SoC Clock Cleanups for v3.16,
such requests, tagged as renesas-clock-cleanup2-for-v3.16,
which I have already sent a pull-request for.


This series includes dependencies that do not fit easily into the usual
inter-branch dependencies and as such I have grouped them together in a
single branch.

The following changes since commit c17fcfbcc0f6b4f3cae761149e1a6108dd6750e7:

  ARM: shmobile: r7s72100: Switch to new style MTU2 device (2014-05-11 19:35:28 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-scif-for-v3.16

for you to fetch changes up to 5ba55fa81aee9493928c245f142a0bfe9f32d02f:

  ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT (2014-05-14 09:56:38 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC dt-scif Updates for v3.16

r8a7791 (R-Car M2) based Koelsch board and
r8a7790 (R-Car H1) based Lager board
* Enable SCIF0 and SCIF1 serial ports in DT

----------------------------------------------------------------
Laurent Pinchart (2):
      ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
      ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT

 arch/arm/boot/dts/r8a7790-lager.dts              | 21 ++++++++++++++++++++-
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 21 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-koelsch-reference.c | 15 ---------------
 arch/arm/mach-shmobile/board-lager-reference.c   | 10 ----------
 arch/arm/mach-shmobile/setup-r8a7790.c           | 10 +++++-----
 arch/arm/mach-shmobile/setup-r8a7791.c           | 10 +++++-----
 6 files changed, 50 insertions(+), 37 deletions(-)
