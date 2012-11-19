From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 19 Nov 2012 15:12:03 +0530
Subject: [GIT PULL] DaVinci fix for v3.7
Message-ID: <50A9FEEB.50305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following DaVinci fix for v3.7? I know its pretty late,
I was out of office for most of the -rc cycle this time.

The change deserves a stable tag, I did not add it though since the patch
does not apply cleanly to any of the previous kernel releases. It will have
to be backported and send to the stable team once it makes it into mainline.

Thanks,
Sekhar

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-fixes-for-v3.7

for you to fetch changes up to e37212aa5df1937bc19c0d0982d216675020a7ca:

  ARM: davinci: dm644x: fix out range signal for ED (2012-11-19 13:07:39 +0530)

----------------------------------------------------------------
Fixes an "signal out of range" error when using enhanced
definition display with a DaVinci DM644x device.

----------------------------------------------------------------
Lad, Prabhakar (1):
      ARM: davinci: dm644x: fix out range signal for ED

 arch/arm/mach-davinci/dm644x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
