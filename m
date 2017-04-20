From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Apr 2017 10:17:49 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.12, take 2
Message-ID: <20170420081749.bok3wwusmk2no5vw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here are the few last minor fixes that didn't go through for 4.11,
plus two fixes for previous drivers changes found in the earlier pull
request for 4.12.

Thanks!
Maxime

The following changes since commit cb545960dea2749771c88b0cb26e5adfd12a0315:

  clk: sunxi-ng: Display index when clock registration fails (2017-04-06 09:10:30 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.12-2

for you to fetch changes up to 7149c1becddf49022fe0aad2fa395377cd8f753e:

  clk: sunxi-ng: a80: Fix audio PLL comment not matching actual code (2017-04-13 14:09:30 +0200)

----------------------------------------------------------------
Allwinner clock changes, take 2

A few minor bug and comment fixes, plus some fixes for the PRCM CCU driver
merged in the prior pull request

----------------------------------------------------------------
Chen-Yu Tsai (3):
      clk: sunxi-ng: use 1 as fallback for minimum multiplier
      clk: sunxi-ng: Fix round_rate/set_rate multiplier minimum mismatch
      clk: sunxi-ng: a80: Fix audio PLL comment not matching actual code

Icenowy Zheng (2):
      clk: sunxi-ng: fix PRCM CCU ir clk parent
      clk: sunxi-ng: fix PRCM CCU CLK_NUMBER value

 drivers/clk/sunxi-ng/ccu-sun8i-r.c   | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.h   | 2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c | 3 +--
 drivers/clk/sunxi-ng/ccu_nk.c        | 8 ++++----
 drivers/clk/sunxi-ng/ccu_nkm.c       | 8 ++++----
 drivers/clk/sunxi-ng/ccu_nkmp.c      | 8 ++++----
 drivers/clk/sunxi-ng/ccu_nm.c        | 4 ++--
 7 files changed, 17 insertions(+), 18 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/78e44516/attachment.sig>
