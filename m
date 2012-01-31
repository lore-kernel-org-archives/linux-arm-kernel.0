From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 23:40:53 +0800
Subject: [GIT PULL] mxs/boards for v3.4
Message-ID: <20120131154051.GF26436@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following mxs board changes for v3.4.  It has no
conflict with rmk/for-armsoc branch.

Regards,
Shawn

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/boards

Fabio Estevam (2):
      ARM: mx28: Remove duplicate OCOTP error message
      ARM: mx28evk: Simplify GPIO requests

Shawn Guo (1):
      ARM: mxs: detect SoC by checking CHIPID register

Wolfram Sang (1):
      ARM: mxs: read correct values when setting up MAC

 arch/arm/mach-mxs/include/mach/digctl.h     |    1 +
 arch/arm/mach-mxs/include/mach/mxs.h        |   29 +++++----
 arch/arm/mach-mxs/include/mach/uncompress.h |   13 ++--
 arch/arm/mach-mxs/mach-m28evk.c             |    7 +--
 arch/arm/mach-mxs/mach-mx28evk.c            |   80 ++++++---------------------
 5 files changed, 43 insertions(+), 87 deletions(-)
