From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Mar 2013 14:47:19 +0800
Subject: [GIT PULL] mxs fixes for 3.9
Message-ID: <20130304064717.GG30431@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-fixes-3.9

for you to fetch changes up to 95381f38c0ed85be732553bf56f613ce701d411b:

  ARM: mxs: ocotp: Fix sparse warning (2013-03-04 10:07:28 +0800)

----------------------------------------------------------------
The mxs fixes for 3.9:
 - A few sparse warning fixes
 - Fix usb function regression caused by usb Kconfig option changes

----------------------------------------------------------------
Fabio Estevam (4):
      ARM: mxs_defconfig: Make USB host functional again
      ARM: mxs: mm: Fix sparse warning
      ARM: mxs: icoll: Fix sparse warning
      ARM: mxs: ocotp: Fix sparse warning

 arch/arm/configs/mxs_defconfig |    1 +
 arch/arm/mach-mxs/icoll.c      |    2 +-
 arch/arm/mach-mxs/mm.c         |    1 +
 arch/arm/mach-mxs/ocotp.c      |    1 +
 4 files changed, 4 insertions(+), 1 deletion(-)
