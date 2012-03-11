From: nsekhar@ti.com (Nori, Sekhar)
Date: Sun, 11 Mar 2012 07:36:55 +0000
Subject: [GIT PULL v2] DaVinci DM644x video display support
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317F13DB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull these two patches adding support
for DaVinci DM644x V4L2 display support for v3.4.

These patches heavily depend on the clean-up series sent
earlier. I have re-generated the pull request against
v3.4/cleanup branch of my tree (already pulled earlier
and unchanged since) as suggested by Olof.

Let me know if this works for you.

Thanks,
Sekhar

The following changes since commit 12db9588ff811ae43a476b1234b27323055ab3ad:
  Manjunath Hadli (1):
        ARM: davinci: dm644x: don't force vpfe registeration on all boards

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git v3.4/features

Manjunath Hadli (2):
      ARM: davinci: dm644x: add support for v4l2 video display
      ARM: davinci: dm644x evm: add support for VPBE display

 arch/arm/mach-davinci/board-dm644x-evm.c |  109 +++++++++++++++++++-
 arch/arm/mach-davinci/davinci.h          |    8 ++-
 arch/arm/mach-davinci/dm644x.c           |  166 +++++++++++++++++++++++++++---
 3 files changed, 268 insertions(+), 15 deletions(-)
