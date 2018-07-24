From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 15:22:19 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.19
Message-ID: <20180724132219.6z4fvvarmhvs5p44@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.19

for you to fetch changes up to 0195156340d365540c7dfa239232065826904f59:

  clk: sunxi-ng: add A64 compatible string (2018-06-27 20:29:08 +0200)

----------------------------------------------------------------
Allwinner clock changes for 4.19

Our usual bunch of clock patches, this time to enable the A64 display
engine clocks controller mostly.

----------------------------------------------------------------
Icenowy Zheng (2):
      dt-bindings: add compatible string for the A64 DE2 CCU
      clk: sunxi-ng: add A64 compatible string

Jernej Skrabec (3):
      clk: sunxi-ng: r40: Add minimal rate for video PLLs
      clk: sunxi-ng: r40: Allow setting parent rate to display related clocks
      clk: sunxi-ng: r40: Export video PLLs

 .../devicetree/bindings/clock/sun8i-de2.txt        |  1 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               | 11 ++--
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               | 58 ++++++++++++----------
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h               |  8 ++-
 include/dt-bindings/clock/sun8i-r40-ccu.h          |  4 ++
 5 files changed, 47 insertions(+), 35 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/f7cb2486/attachment.sig>
