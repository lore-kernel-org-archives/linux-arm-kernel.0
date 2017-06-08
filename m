From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Jun 2017 16:53:50 +0530
Subject: [GIT PULL 3/3] DaVinci defconfig updates for v4.13
In-Reply-To: <20170608112350.1602-1-nsekhar@ti.com>
References: <20170608112350.1602-1-nsekhar@ti.com>
Message-ID: <20170608112350.1602-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.13/defconfig

for you to fetch changes up to 0b997c8c9562dd61733dfeb9e1a5962730338e6e:

  ARM: davinci_all_defconfig: Enable CPPI 4.1 USB OTG DMA (2017-05-30 16:12:51 +0530)

----------------------------------------------------------------
Re-sync of davinci_all_defconfig with savedefconfig and enable
CPPI 4.1 DMA for MUSB, some commonly used USB devices, and
Lego Mindstorms EV3 battery driver.

----------------------------------------------------------------
Alexandre Bailon (1):
      ARM: davinci_all_defconfig: Enable CPPI 4.1 USB OTG DMA

David Lechner (1):
      ARM: davinci_all_defconfig: enable LEGO MINDSTORMS EV3 battery module

Sekhar Nori (2):
      ARM: davinci_all_defconfig: cleanup with savedefconfig
      ARM: davinci_all_defconfig: enable USB audio/video device support

 arch/arm/configs/davinci_all_defconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
