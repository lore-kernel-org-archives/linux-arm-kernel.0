From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 14 Mar 2012 06:46:57 +0000
Subject: [GIT PULL] DaVinci fixes for v3.3
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317F5E48@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following DaVinci fixes for v3.3.
They fix a build and section mismatch warning.

Thanks,
Sekhar

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:
  Linus Torvalds (1):
        Linux 3.3-rc7

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git fixes

Uwe Kleine-K??????nig (2):
      ARM: davinci: cpufreq: fix compiler warning
      ARM: davinci: DA850: move da850_register_pm to .init.text

 arch/arm/mach-davinci/cpufreq.c |    2 +-
 arch/arm/mach-davinci/da850.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-
