From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 22:23:32 +0100
Subject: [GIT PULL] Allwinner clock fixes for 4.9
Message-ID: <20161115212332.w5amyhohmauqzpe5@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following fixes for the 4.9 cycle

Thanks!
Maxime

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-fixes-for-4.9

for you to fetch changes up to ac95330b96376550ae7a533d1396272d675adfa2:

  clk: sunxi: Fix M factor computation for APB1 (2016-11-04 08:49:46 +0100)

----------------------------------------------------------------
Allwinner clock fixes for 4.9

Two fixes, one for the old clock code, one for the new implementation.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: sun6i-a31: Force AHB1 clock to use PLL6 as parent

St?phan Rafin (1):
      clk: sunxi: Fix M factor computation for APB1

 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 12 ++++++++++++
 drivers/clk/sunxi/clk-sunxi.c        |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/edb7507a/attachment.sig>
