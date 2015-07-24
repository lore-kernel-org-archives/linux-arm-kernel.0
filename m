From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:58 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.3
Message-ID: <cover.1437725057.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.3.


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.3

for you to fetch changes up to 765b50030c218f65ee4ffd2eeb07045aa79fd5ee:

  ARM: shmobile: gose: enable R-Car Gen2 regulator quirk (2015-07-06 09:37:24 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.3

* Add basic support for gose/r8a7793

----------------------------------------------------------------
Ulrich Hecht (2):
      ARM: shmobile: Basic r8a7793 SoC support
      ARM: shmobile: gose: enable R-Car Gen2 regulator quirk

 arch/arm/mach-shmobile/Kconfig                     |  5 ++++
 arch/arm/mach-shmobile/Makefile                    |  2 ++
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c |  3 +-
 arch/arm/mach-shmobile/setup-r8a7793.c             | 33 ++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
