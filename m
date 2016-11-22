From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Nov 2016 15:59:49 +0100
Subject: [GIT PULL] Allwinner clock fixes for 4.9, take 2
Message-ID: <20161122145949.quvtzoupxbxbeql6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here are two new fixes for the 4.9 release.

That should be my final PR for both the 4.9 fixes and 4.10
developments.

Thanks!
Maxime

The following changes since commit ac95330b96376550ae7a533d1396272d675adfa2:

  clk: sunxi: Fix M factor computation for APB1 (2016-11-04 08:49:46 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-fixes-for-4.9-2

for you to fetch changes up to df8e3c1fe1050fa2749c346676d12f4d30dcd935:

  clk: sunxi-ng: enable so-said LDOs for A33 SoC's pll-mipi clock (2016-11-21 19:50:49 +0100)

----------------------------------------------------------------
Allwinner clock fixes for 4.9, take 2

Two new patches to fix the gating of the MIPI PLL on the A23, A31 and A33.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: sun6i-a31: Enable PLL-MIPI LDOs when ungating it

Icenowy Zheng (1):
      clk: sunxi-ng: enable so-said LDOs for A33 SoC's pll-mipi clock

 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161122/ca7df353/attachment.sig>
