From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Dec 2013 07:45:54 -0800
Subject: [GIT PULL] ARM: SoC fixes for 3.13-rc
Message-ID: <20131229154554.GA14633@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:

  Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 9b17c16525552b247cb2d9bb8eeadc87950b36ff:

  Merge tag 'omap-for-v3.13/intc-ldp-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2013-12-28 15:38:32 -0800)

----------------------------------------------------------------

ARM: SoC fixes for 3.13-rc

Another smallish batch of fixes, it's been quiet due to the holidays. Nothing
controversial here, a handful of things across the board.

----------------------------------------------------------------
Ben Dooks (1):
      ARM: shmobile: r8a7790: fix shdi resource sizes

Kuninori Morimoto (1):
      ARM: shmobile: bockw: fixup DMA mask

Laurent Pinchart (1):
      ARM: shmobile: armadillo: Add PWM backlight power supply

Linus Walleij (1):
      ARM: pxa: fix USB gadget driver compilation regression

Olof Johansson (2):
      Merge tag 'renesas-fixes2-for-v3.13' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'omap-for-v3.13/intc-ldp-fix' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Rajendra Nayak (1):
      ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL

Suman Anna (1):
      ARM: OMAP2+: hwmod_data: fix missing OMAP_INTC_START in irq data

Tony Lindgren (2):
      ARM: OMAP2+: Fix LCD panel backlight regression for LDP legacy booting
      Merge tag 'for-v3.13-rc/hwmod-fixes-b' of git://git.kernel.org/.../pjw/omap-pending into debug-ll-and-ldp-backlight-fix

 arch/arm/boot/dts/r8a7790.dtsi                     | 4 ++--
 arch/arm/mach-omap2/board-ldp.c                    | 7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 4 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 6 +++---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 2 +-
 arch/arm/mach-pxa/include/mach/lubbock.h           | 2 ++
 arch/arm/mach-shmobile/board-armadillo800eva.c     | 7 +++++++
 arch/arm/mach-shmobile/board-bockw.c               | 2 +-
 8 files changed, 24 insertions(+), 10 deletions(-)
