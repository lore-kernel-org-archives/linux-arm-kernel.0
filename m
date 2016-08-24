From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 24 Aug 2016 16:30:06 +0530
Subject: [GIT PULL 3/3] DaVinci defconfig updates for v4.9
In-Reply-To: <20160824110006.1866-1-nsekhar@ti.com>
References: <20160824110006.1866-1-nsekhar@ti.com>
Message-ID: <20160824110006.1866-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.9/defconfig

for you to fetch changes up to c6144fb8ec5328110ca7bf4682167a95590fd7ec:

  ARM: davinci_all_defconfig: Enable some UBI modules (2016-08-23 16:22:19 +0530)

----------------------------------------------------------------
DaVinci defconfig updates include cleanup using
savedefconfig and enabling various commonly used
drivers as modules.

----------------------------------------------------------------
Karl Beldan (4):
      ARM: davinci_all_defconfig: enable RTC driver as module
      ARM: davinci_all_defconfig: enable SMSC ethernet PHY
      ARM: davinci_all_defconfig: Enable AEMIF as a module
      ARM: davinci_all_defconfig: Enable some UBI modules

Kevin Hilman (2):
      ARM: davinci_all_defconfig: cleanup with savedefconfig
      ARM: davinci_all_defconfig: enable DA850 audio as modules

 arch/arm/configs/davinci_all_defconfig | 66 +++++++++++++---------------------
 1 file changed, 25 insertions(+), 41 deletions(-)
