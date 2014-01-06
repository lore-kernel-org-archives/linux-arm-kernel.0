From: bcm@fixthebug.org (Christian Daudt)
Date: Sun, 5 Jan 2014 23:03:41 -0800
Subject: [GIT PULL] bcm soc updates for 3.14
Message-ID: <CAEPRUYrKuXWjEhBcCPq275fK4bmPu11H_NE-hB5s7cL+Oa4NRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://github.com/broadcom/bcm11351.git tags/bcm-for-3.14-soc

for you to fetch changes up to 047ef2fa4e687b6c0d4e7d47b8a184147151482c:

  rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource) (2013-12-13 08:36:22 -0800)

----------------------------------------------------------------
Various defconfig udpates to bcm mobile

----------------------------------------------------------------
Christian Daudt (1):
      rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)

Tim Kryger (3):
      ARM: bcm_defconfig: CONFIG_OABI_COMPAT default off
      ARM: bcm_defconfig: Do not expect appended DTB
      ARM: bcm_defconfig: Unset CONFIG_CRYPTO_ANSI_CPRNG

 arch/arm/configs/bcm_defconfig | 3 +--
 drivers/clocksource/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)
