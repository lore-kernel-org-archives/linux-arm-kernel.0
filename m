From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 24 Aug 2016 16:30:04 +0530
Subject: [GIT PULL 1/3] DaVinci soc support updates for v4.9
Message-ID: <20160824110006.1866-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.9/soc

for you to fetch changes up to 8f899b4ed6918ee4f7b87654f772bdaa0d580124:

  ARM: davinci: da850: Add ti-aemif lookup for clock matching (2016-08-23 20:20:33 +0530)

----------------------------------------------------------------
DA850 SoC support update for making it possible
to use TI AEMIF driver in drivers/memory on DA850.

----------------------------------------------------------------
Karl Beldan (1):
      ARM: davinci: da850: Add ti-aemif lookup for clock matching

 arch/arm/mach-davinci/da850.c    | 1 +
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 2 files changed, 2 insertions(+)
