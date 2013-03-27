From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 22:59:39 +0900
Subject: [GIT PULL] Renesas fbdev fixes for v3.9
Message-ID: <1364392780-3847-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fbdev-fixes-for-v3.9

for you to fetch changes up to 9beb09f1cadf33145c307c504f844ae24686c872:

  fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings (2013-03-27 22:47:24 +0900)

----------------------------------------------------------------
Renesas fbdev fixes for v3.9

A fix from Morimoto-san to correct the horizontal location of output.

I apologise for this being posted late in the cycle.

----------------------------------------------------------------
Kuninori Morimoto (1):
      fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings

 drivers/video/sh_mobile_lcdcfb.c |    1 +
 1 file changed, 1 insertion(+)
