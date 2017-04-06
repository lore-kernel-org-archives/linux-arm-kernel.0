From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Apr 2017 09:41:21 +0200
Subject: [GIT PULL] Allwinner clock fixes for 4.11, bis
Message-ID: <20170406074121.tkivdvghbr27tr54@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following changes for one of the 4.11-rc's

Thanks!
Maxime

The following changes since commit b467e08a15563dede0d37d3233baa24fb97a7310:

  clk: sunxi-ng: fix recalc_rate formula of NKMP clocks (2017-03-20 10:34:05 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.11-2

for you to fetch changes up to d054a839a0986136374d49f9f9fbc264abae9c4c:

  clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER (2017-03-27 13:37:05 +0200)

----------------------------------------------------------------
Allwinner clock fixes for 4.11, bis

A few patches to fix a build error and a few minor typos and bugs in the
sunxi-ng code

----------------------------------------------------------------
Chen-Yu Tsai (3):
      clk: sunxi-ng: use 1 as fallback for minimum multiplier
      clk: sunxi-ng: Fix round_rate/set_rate multiplier minimum mismatch
      clk: sunxi-ng: a80: Fix audio PLL comment not matching actual code

Tobias Regnery (1):
      clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER

 drivers/clk/sunxi-ng/Kconfig         | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c | 3 +--
 drivers/clk/sunxi-ng/ccu_nk.c        | 8 ++++----
 drivers/clk/sunxi-ng/ccu_nkm.c       | 8 ++++----
 drivers/clk/sunxi-ng/ccu_nkmp.c      | 8 ++++----
 drivers/clk/sunxi-ng/ccu_nm.c        | 4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/a5ee35fa/attachment-0001.sig>
