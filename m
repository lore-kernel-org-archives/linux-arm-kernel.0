From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Oct 2015 21:58:56 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.4
Message-ID: <20151021195856.GA5155@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following patches for the next merge window.

Thanks!
Maxime

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-4.4

for you to fetch changes up to 9b038bc58ad2658c76fd8b50bb333dfd4454573c:

  clk: sunxi: mod1 clock support (2015-10-21 21:51:29 +0200)

----------------------------------------------------------------
Allwinner clock additions for 4.4

  - Support for the Audio PLL and child clocks
  - Support for the A33 AHB gates
  - New clk-multiplier generic driver

----------------------------------------------------------------
Emilio L?pez (2):
      clk: sunxi: codec clock support
      clk: sunxi: mod1 clock support

Maxime Ripard (4):
      clk: sunxi: Add A33 gates support
      clk: Add a basic multiplier clock
      clk: sunxi: Add a driver for the PLL2
      clk: sunxi: pll2: Add A13 support

 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk-multiplier.c               | 181 ++++++++++++++++++++++++
 drivers/clk/sunxi/Makefile                 |   3 +
 drivers/clk/sunxi/clk-a10-codec.c          |  44 ++++++
 drivers/clk/sunxi/clk-a10-mod1.c           |  81 +++++++++++
 drivers/clk/sunxi/clk-a10-pll2.c           | 216 +++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-simple-gates.c       |   2 +
 include/dt-bindings/clock/sun4i-a10-pll2.h |  53 +++++++
 include/linux/clk-provider.h               |  42 ++++++
 9 files changed, 623 insertions(+)
 create mode 100644 drivers/clk/clk-multiplier.c
 create mode 100644 drivers/clk/sunxi/clk-a10-codec.c
 create mode 100644 drivers/clk/sunxi/clk-a10-mod1.c
 create mode 100644 drivers/clk/sunxi/clk-a10-pll2.c
 create mode 100644 include/dt-bindings/clock/sun4i-a10-pll2.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151021/adf4c243/attachment.sig>
