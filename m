From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:48 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.11
Message-ID: <cover.1483701101.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.11.


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.11

for you to fetch changes up to 70def3e53694a65c5583fb5f411491a5074bab18:

  ARM: shmobile: rcar-gen2: Remove unused rcar_gen2_read_mode_pins() (2017-01-03 10:50:45 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.11

* Allow booting secondary CPU cores in debug mode

----------------------------------------------------------------
Geert Uytterhoeven (5):
      ARM: shmobile: apmu: Add more register documentation
      ARM: shmobile: apmu: Add debug resource reset for secondary CPU boot
      ARM: shmobile: apmu: Allow booting secondary CPU cores in debug mode
      ARM: shmobile: r8a7791: Allow booting secondary CPU cores in debug mode
      ARM: shmobile: rcar-gen2: Remove unused rcar_gen2_read_mode_pins()

 arch/arm/mach-shmobile/platsmp-apmu.c    | 41 +++++++++++++++++++-------------
 arch/arm/mach-shmobile/rcar-gen2.h       |  2 --
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 18 --------------
 arch/arm/mach-shmobile/smp-r8a7791.c     | 14 +----------
 4 files changed, 25 insertions(+), 50 deletions(-)
