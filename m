From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 21 May 2018 13:53:05 +0200
Subject: [GIT PULL] Allwinner fixes for 4.17
Message-ID: <20180521115305.6ebm26zqx4a3rftv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are our fixes for the 4.17 release.

Thanks!
Maxime

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi-fixes-for-4.17

for you to fetch changes up to d89ad4f0b44dde8c5333ef7a5d5824829cc72de3:

  ARM: sun8i: v3s: fix spelling mistake: "disbaled" -> "disabled" (2018-05-02 14:10:58 +0200)

----------------------------------------------------------------
Allwinner fixes for 4.17

Here is a bunch of fixes for merge issues, typos and wrong clocks being
described for simplefb, resulting in non-working displays.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sun8i: h3: Re-enable EMAC on Orange Pi One

Colin Ian King (1):
      ARM: sun8i: v3s: fix spelling mistake: "disbaled" -> "disabled"

Pascal Roeleven (1):
      ARM: dts: sun4i: Fix incorrect clocks for displays

 arch/arm/boot/dts/sun4i-a10.dtsi                   | 6 +++---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 1 +
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/67e3a62e/attachment.sig>
