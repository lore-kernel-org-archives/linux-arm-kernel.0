From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sat, 29 Sep 2018 17:05:06 +0200
Subject: [GIT PULL] Allwinner clock fixes for 4.19
Message-ID: <20180929150506.vch5wuujblgkngfp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is one fix for 4.19.

Thanks!
Maxime

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.19

for you to fetch changes up to 80a6ec7d5e1653208eb53f6738620dab98f6f50e:

  clk: sunxi-ng: sun4i: Set VCO and PLL bias current to lowest setting (2018-09-07 10:20:50 +0200)

----------------------------------------------------------------
Allwinner clk fixes for 4.19

One fix for the Audio PLL that were not properly set and generating noise
on the A10 SoCs.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: sun4i: Set VCO and PLL bias current to lowest setting

 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180929/435fb983/attachment.sig>
