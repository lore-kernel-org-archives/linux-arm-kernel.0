From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 24 Feb 2012 21:45:51 +0000
Subject: [GIT PULL] DaVinci fix for v3.4
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317D2DDA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following DaVinci fix for v3.4?
It has no conflicts with rmk/for-armsoc branch of the
arm-soc tree or with latest linux-next.

Thanks,
Sekhar

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:
  Linus Torvalds (1):
        Linux 3.3-rc2

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git v3.4/fixes

Heiko Schocher (1):
      ARM: davinci: map default_queue to edma channels

 arch/arm/mach-davinci/dma.c               |    6 +-----
 arch/arm/mach-davinci/include/mach/edma.h |    5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)
