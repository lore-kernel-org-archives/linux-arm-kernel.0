From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 2 Dec 2011 14:03:53 +0800
Subject: [GIT PULL] mxs: saif recording support
Message-ID: <20111202060352.GO711@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the imx28 saif recording support below.

-- 
Regards,
Shawn

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/saif-recording

Dong Aisheng (4):
      ASoC: mxs-saif: remove function in platform_data
      ARM: mxs: add saif clkmux functions
      ARM: mx28evk: add platform data for saif
      ARM: mx28evk: set a initial clock rate for saif

 arch/arm/mach-mxs/clock-mx28.c                  |   38 +++++++++++++++++++++++
 arch/arm/mach-mxs/devices-mx28.h                |    3 +-
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 ++-
 arch/arm/mach-mxs/include/mach/common.h         |    1 +
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 ++-
 arch/arm/mach-mxs/include/mach/digctl.h         |   21 ++++++++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   18 +++++++++-
 include/sound/saif.h                            |    4 +-
 sound/soc/mxs/mxs-saif.c                        |   20 +++++------
 9 files changed, 95 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
