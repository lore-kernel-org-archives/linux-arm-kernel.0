From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Dec 2011 11:14:52 -0800
Subject: [GIT PULL 1/5] Tegra cleanups for 3.3
Message-ID: <CAOesGMja7+nA-VSF9bEmUJRbpLbVwZ+ngC1+qJ4Sz8L3Bx0m5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following cleanups for tegra. Thanks!


The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/cleanup

Olof Johansson (1):
      arm/tegra: fix variable formatting in makefile

Stephen Warren (1):
      arm/tegra: Remove code that's ifndef CONFIG_ARM_GIC

pdeschrijver at nvidia.com (1):
      arm/tegra: remove unused defines

 arch/arm/mach-tegra/Makefile                   |   26 ++++++++++++------------
 arch/arm/mach-tegra/include/mach/entry-macro.S |   23 ---------------------
 arch/arm/mach-tegra/irq.c                      |    4 ---
 3 files changed, 13 insertions(+), 40 deletions(-)
