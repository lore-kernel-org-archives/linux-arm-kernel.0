From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 15 Apr 2016 17:44:48 +0530
Subject: [GIT PULL 3/3] DaVinci DT updates for v4.7
In-Reply-To: <1460722488-5921-1-git-send-email-nsekhar@ti.com>
References: <1460722488-5921-1-git-send-email-nsekhar@ti.com>
Message-ID: <1460722488-5921-3-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.7/dt

for you to fetch changes up to 6c8f73592203b8611c6ba5d4c670c82a059ecf27:

  ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for i2c1 (2016-04-14 11:41:04 +0530)

----------------------------------------------------------------
Device-Tree updates for DaVinci. This
contains some clean-up and fixes of
device-tree data and addition of i2c1
node for DA850.

----------------------------------------------------------------
David Lechner (1):
      ARM: dts: davinci: use proper address after @

Petr Kulhavy (3):
      ARM: DTS: da850: fix missing #gpio-cells in gpio node
      ARM: DTS: da850: add node for i2c1
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for i2c1

 arch/arm/boot/dts/da850-enbw-cmc.dts |  8 ++---
 arch/arm/boot/dts/da850-evm.dts      | 26 +++++++-------
 arch/arm/boot/dts/da850.dtsi         | 67 ++++++++++++++++++++++--------------
 arch/arm/mach-davinci/da8xx-dt.c     |  1 +
 4 files changed, 59 insertions(+), 43 deletions(-)
