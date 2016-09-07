From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Sep 2016 21:33:35 +0200
Subject: [GIT PULL] Allwinner clock fixes for 4.8
Message-ID: <20160907193335.GA4283@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following tag for the 4.8 release.

Thanks!
Maxime

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-fixes-for-4.8

for you to fetch changes up to 6654674cb7b5953ac04fc9d7f5f511676ae97e29:

  clk: sunxi-ng: Fix wrong reset register offsets (2016-08-29 08:38:55 +0200)

----------------------------------------------------------------
Clock Fixes for the Allwinner SoCs, 4.8 Edition

The usual bunch of fixes to the our clock drivers, mostly targetted to the
brand new sunxi-ng drivers.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      clk: sunxi-ng: Fix inverted test condition in ccu_helper_wait_for_lock
      clk: sunxi-ng: nk: Make ccu_nk_find_best static

Jorik Jonker (1):
      clk: sunxi-ng: Fix wrong reset register offsets

Wei Yongjun (2):
      clk: sunxi: pll2: Fix return value check in sun4i_pll2_setup()
      clk: sunxi: Fix return value check in sun8i_a23_mbus_setup()

 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 16 ++++++++--------
 drivers/clk/sunxi-ng/ccu_common.c   |  2 +-
 drivers/clk/sunxi-ng/ccu_nk.c       |  6 +++---
 drivers/clk/sunxi/clk-a10-pll2.c    |  4 ++--
 drivers/clk/sunxi/clk-sun8i-mbus.c  |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/ce6b5177/attachment.sig>
