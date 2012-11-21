From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Nov 2012 15:28:54 -0800
Subject: [GIT PULL] ARM: SoC fixes for 3.7
Message-ID: <20121121232854.GB18134@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 65546ab097b023886a60df4cbc931d4cc362b98e:

  Merge tag 'omap-for-v3.7-rc5/fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2012-11-21 13:56:36 -0800)

----------------------------------------------------------------

ARM: SoC fixes for 3.7

A few more fixes for final 3.7. Two dealing with pinmux setup on OMAP, and
one dealing with TV output on DaVinci. And one small MAINTAINER update.

----------------------------------------------------------------
Anders Hedlund (1):
      ARM: OMAP3: igep0020: Set WIFI/BT GPIO pins in correct mux mode

Javier Martinez Canillas (1):
      ARM: OMAP: Add maintainer entry for IGEP machines

Kevin Hilman (1):
      ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC

Lad, Prabhakar (1):
      ARM: davinci: dm644x: fix out range signal for ED

Olof Johansson (2):
      Merge tag 'davinci-fixes-for-v3.7' of git://gitorious.org/linux-davinci/linux-davinci into fixes
      Merge tag 'omap-for-v3.7-rc5/fixes-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

 MAINTAINERS                          | 8 ++++++++
 arch/arm/mach-davinci/dm644x.c       | 3 +--
 arch/arm/mach-omap2/board-igep0020.c | 5 +++++
 arch/arm/mach-omap2/twl-common.c     | 1 +
 4 files changed, 15 insertions(+), 2 deletions(-)
