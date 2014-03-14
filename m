From: mporter@linaro.org (Matt Porter)
Date: Fri, 14 Mar 2014 15:30:53 -0400
Subject: [GIT PULL] ARM: mach-bcm soc updates for 3.15 - part 2
Message-ID: <20140314193053.GA5726@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pull request adds support for a new Broadcom mobile SoC family that
depends on previously pulled cleanups. Because of this, it's not coming
from the previous branch that was pulled, but rather a new branch that
is a merge of the previously pulled cleanup and soc-2 branches.

Thanks,
Matt

The following changes since commit 833688f4e49f659ad90a3ea7e2905720774c3f61:

  Merge tag 'armsoc/for-3.15/soc-2' into armsoc/for-3.15/soc-3 (2014-03-14 11:20:43 -0400)

are available in the git repository at:


  git://github.com/broadcom/mach-bcm tags/armsoc/for-3.15/soc-3

for you to fetch changes up to 7aa2077b55b530fac878e7c05fc970a778eb3950:

  ARM: restrict BCM_KONA_UART to ARCH_BCM_MOBILE (2014-03-14 11:37:33 -0400)

----------------------------------------------------------------
ARM: mach-bcm: soc updates for 3.15 - part 2

- Add bcm21664 support
- Use Kona Debug UART only on ARCH_BCM_MOBILE

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: restrict BCM_KONA_UART to ARCH_BCM_MOBILE

Markus Mayer (1):
      ARM: bcm21664: Add board support.

 arch/arm/Kconfig.debug             |  2 +-
 arch/arm/mach-bcm/Makefile         |  6 ++-
 arch/arm/mach-bcm/board_bcm21664.c | 78 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-bcm/board_bcm21664.c
