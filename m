From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Apr 2014 11:15:32 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v3.16
Message-ID: <cover.1398737464.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of
Renesas ARM based SoC DT updates for v3.16.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v3.16,
which I have already sent a pull-request for.


The following changes since commit dd485ab9a88267f4db0d58ace23b19e876ebf8ac:

  ARM: shmobile: armadillo-reference dts: Seiko Instruments, Inc is "sii" (2014-04-16 10:03:42 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.16

for you to fetch changes up to 5a62ec57004f1a434bfd3feed43e447b5780baf6:

  ARM: shmobile: henninger: enable SATA0 (2014-04-28 09:12:04 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v3.16

* Add r8a7791 (R-Car M2) based Henninger board

----------------------------------------------------------------
Sergei Shtylyov (3):
      ARM: shmobile: henninger: initial device tree
      ARM: shmobile: henninger: add Ether DT support
      ARM: shmobile: henninger: enable SATA0

 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/r8a7791-henninger.dts | 80 +++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-henninger.dts
