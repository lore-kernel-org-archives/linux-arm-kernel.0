From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Apr 2016 18:49:33 +0200
Subject: [GIT PULL] Allwinner clocks additions for 4.7
Message-ID: <20160429164933.GA8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following tag for the next merge window.

Thanks!
Maxime

The following changes since commit 92a39d9043ba5ff98adb1c31491f00c7bea5466e:

  clk: composite: Add unregister function (2016-04-21 14:43:28 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-4.7

for you to fetch changes up to ff2bb89335daec6053b5ac778369f7f72b931142:

  clk: sunxi: Let divs clocks read the base factor clock name from devicetree (2016-04-25 10:57:45 +0200)

----------------------------------------------------------------
Allwinner clocks additions for 4.7

As usual, a bunch of clocks patches for 4.7, mostly fixes and cleanups, and
display-related clocks.

----------------------------------------------------------------
Andrea Venturi (1):
      clk: sunxi: mod1 clock should modify it's parent

Jean-Francois Moine (1):
      clk: sunxi: Add sun6i/8i display support

Jens Kuske (1):
      clk: sunxi: Let divs clocks read the base factor clock name from devicetree

Maxime Ripard (3):
      dt-bindings: clk: sun5i: add DRAM gates compatible
      clk: sunxi: Add PLL3 clock
      clk: sunxi: Add TCON channel1 clock

Vaishali Thakkar (1):
      clk: sunxi: Use resource_size

 Documentation/devicetree/bindings/clock/sunxi.txt |   4 +
 drivers/clk/sunxi/Makefile                        |   2 +
 drivers/clk/sunxi/clk-a10-mod1.c                  |   2 +-
 drivers/clk/sunxi/clk-sun4i-pll3.c                |  98 +++++++
 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c            | 300 ++++++++++++++++++++++
 drivers/clk/sunxi/clk-sun9i-mmc.c                 |   2 +-
 drivers/clk/sunxi/clk-sunxi.c                     |  79 +++++-
 7 files changed, 474 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun4i-pll3.c
 create mode 100644 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/b872c32c/attachment-0001.sig>
