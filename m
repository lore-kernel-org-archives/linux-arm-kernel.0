From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Dec 2009 18:32:03 +0800
Subject: [GIT PULL] pxa: raumfeld support and ttc_dkb fix
Message-ID: <f17812d70912180232m54d59be7l5da1e46c0d84e501@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

This is late due to some dependency issue, actually the raumfeld patches
have been sitting in my pending branch for a very long time. I think it
should be still OK to get this upstreamed.

The following changes since commit 55639353a0035052d9ea6cfe4dde0ac7fcbb2c9f:
  Linus Torvalds (1):
        Linux 2.6.33-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Daniel Mack (2):
      [ARM] pxa/raumfeld: add platform support
      [ARM] pxa/raumfeld: add defconfig

Uwe Kleine-K?nig (1):
      [ARM] pxa/ttc_dkb: remove duplicate macro definition

 arch/arm/configs/raumfeld_defconfig | 1898 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/ttc_dkb.c         |    2 -
 arch/arm/mach-pxa/Kconfig           |   18 +
 arch/arm/mach-pxa/Makefile          |    3 +
 arch/arm/mach-pxa/raumfeld.c        | 1100 ++++++++++++++++++++
 5 files changed, 3019 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/configs/raumfeld_defconfig
 create mode 100644 arch/arm/mach-pxa/raumfeld.c
