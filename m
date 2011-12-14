From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 14 Dec 2011 18:09:31 +0000
Subject: [GIT PULL] DaVinci cleanup for v3.3
Message-ID: <DF0F476B391FA8409C78302C7BA518B6048974@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I have this lone patch queued for DaVinci clean-up so far.
Can you please pull this?

Thanks,
Sekhar

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:
  Linus Torvalds (1):
        Linux 3.2-rc3

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git v3.3/cleanup

Manjunath Hadli (1):
      ARM: davinci: vpif: move code to driver core header from platform

 arch/arm/mach-davinci/include/mach/dm646x.h |   53 +-------------------
 drivers/media/video/davinci/vpif.h          |    1 +
 drivers/media/video/davinci/vpif_capture.h  |    2 +-
 drivers/media/video/davinci/vpif_display.h  |    1 +
 include/media/davinci/vpif_types.h          |   71 +++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 53 deletions(-)
 create mode 100644 include/media/davinci/vpif_types.h
