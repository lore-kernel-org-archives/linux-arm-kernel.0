From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 29 Apr 2016 17:37:06 +0530
Subject: [GIT PULL 3/4] DaVinci defconfig updates for v4.7
In-Reply-To: <1461931627-27761-1-git-send-email-nsekhar@ti.com>
References: <1461931627-27761-1-git-send-email-nsekhar@ti.com>
Message-ID: <1461931627-27761-3-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.7/defconfig

for you to fetch changes up to 8b182f395aa6e41973eff14619f3cdd36a6c67de:

  ARM: davinci_all_defconfig: enable SPI and NOR as modules (2016-04-25 18:37:57 +0530)

----------------------------------------------------------------
Some defconfig updates to support systemd
based filesystems, SPI NOR and GPIO sysfs
entries.

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: davinci_all_defconfig: enable SPI and NOR as modules

Sekhar Nori (2):
      ARM: davinci_all_defconfig: enable GPIO_SYSFS
      ARM: davinci_all_defconfig: support systemd

 arch/arm/configs/davinci_all_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
