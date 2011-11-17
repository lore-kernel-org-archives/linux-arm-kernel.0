From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Nov 2011 20:37:40 +0800
Subject: [GIT PULL] mxs: fixes for v3.2-rc
Message-ID: <20111117123740.GK14656@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the mxs fixes below for v3.2-rc.

Regards,
Shawn

The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:

  Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/fixes

Shawn Guo (1):
      ARM: Update mach-types to fix mxs build breakage

Wolfram Sang (1):
      arm: mx28: fix bit operation in clock setting

 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 arch/arm/tools/mach-types      |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)
