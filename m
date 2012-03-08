From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 8 Mar 2012 19:23:00 +0000
Subject: [GIT PULL] DaVinci DM644x video display support
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317EEB34@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull these two patches adding support
for DaVinci DM644x V4L2 display support for v3.4.

These patches heavily depend on the clean-up series sent earlier.
Since the clean-up series is already included in for-next branch
of arm-soc, I have generated a request using that as baseline.

Let me know if that's not desirable, and I can do it any
other way you want.

Thanks,
Sekhar

The following changes since commit 3a034af7c1a3c55014eeb15a9c9430e9f72810e4:
  Arnd Bergmann (1):
        Merge branch 'next/fixes-non-critical' into for-next

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git v3.4/features

Manjunath Hadli (2):
      ARM: davinci: dm644x: add support for v4l2 video display
      ARM: davinci: dm644x evm: add support for VPBE display

 arch/arm/mach-davinci/board-dm644x-evm.c |  109 +++++++++++++++++++-
 arch/arm/mach-davinci/davinci.h          |    8 ++-
 arch/arm/mach-davinci/dm644x.c           |  166 +++++++++++++++++++++++++++---
 3 files changed, 268 insertions(+), 15 deletions(-)
