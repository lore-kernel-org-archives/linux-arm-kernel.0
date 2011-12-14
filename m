From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 14 Dec 2011 18:34:14 +0000
Subject: [GIT PULL] DaVinci features for v3.3
Message-ID: <DF0F476B391FA8409C78302C7BA518B6048C5C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

I have this lone feature queued for v3.3 so far. Can you please pull?
The patch depends on v3.2-rc5 for build, but I have not rebased to
preserve the commit date.

Thanks,
Sekhar

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:
  Linus Torvalds (1):
        Linux 3.2-rc3

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git v3.3/features

Murali Karicheri (1):
      ARM: davinci: add support for multiple power domains

 arch/arm/mach-davinci/clock.c  |   13 +++----------
 arch/arm/mach-davinci/clock.h  |   10 +++++-----
 arch/arm/mach-davinci/dm644x.c |    4 ++--
 3 files changed, 10 insertions(+), 17 deletions(-)
