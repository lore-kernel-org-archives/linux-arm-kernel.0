From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:55:16 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC Updates for v3.19
Message-ID: <cover.1416531087.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fourth round of Renesas ARM based SoC updates for v3.19.

This pull request is based on the previous round of
such requests, tagged as renesas-soc3-for-v3.19,
which I have already sent a pull-request for.


The following changes since commit e3d163329753b3b473f40c9be71561ed8eb98aea:

  ARM: shmobile: always build rcar setup for armv7 (2014-11-12 18:14:42 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc4-for-v3.19

for you to fetch changes up to 7a2071c58f36450fbf44a27d2e5d371c18534a25:

  ARM: shmobile: Add early debugging support using SCIF(A) (2014-11-17 10:29:58 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC Updates for v3.19

* Add early debugging support using SCIF(A)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: Add early debugging support using SCIF(A)

 MAINTAINERS                            |  1 +
 arch/arm/Kconfig.debug                 | 80 +++++++++++++++++++++++++++++++++-
 arch/arm/include/debug/renesas-scif.S  | 52 ++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c |  1 +
 arch/arm/mach-shmobile/setup-r8a7779.c |  1 +
 arch/arm/mach-shmobile/setup-sh7372.c  |  1 +
 arch/arm/mach-shmobile/setup-sh73a0.c  |  1 +
 7 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/debug/renesas-scif.S
