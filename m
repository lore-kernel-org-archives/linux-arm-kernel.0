From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 24 Sep 2018 22:09:41 +0200
Subject: [GIT PULL] ARM: at91: fixes for 4.19
Message-ID: <20180924200941.GA11498@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is a small fix for an issue seen on the sama5d2 PTC EK.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.19-fixes

for you to fetch changes up to 379e36d3f591cb62e781907edafea17d75e8c1fa:

  ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl (2018-09-12 12:38:04 +0200)

----------------------------------------------------------------
AT91 fixes for 4.19:

 - fix a NAND issue on sama5d2_ptc_ek

----------------------------------------------------------------
Ludovic Desroches (1):
      ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 2 ++
 1 file changed, 2 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
