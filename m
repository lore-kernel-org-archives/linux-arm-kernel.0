From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 May 2016 21:43:57 +0800
Subject: [GIT PULL] i.MX clock updates for 4.7, take 2
Message-ID: <20160503134356.GO5874@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 69c542e8022ca53c5fee664548163809eb1777c3:

  clk: imx: vf610: fix whitespace in vf610-clock.h (2016-04-12 09:31:08 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-4.7-2

for you to fetch changes up to 92a847e3609a8d00bcbe8bdfacbcbbca03135410:

  clk: imx7d: fix ahb clock mux 1 (2016-05-03 20:35:38 +0800)

----------------------------------------------------------------
The i.MX clock updates for 4.7, take 2:
 - Update clk-pllv3 driver to get it return correct frequency for
   Ethernet PLL on i.MX7D.
 - Correct ahb clock mux settings for i.MX7D per latest hardware
   document.

----------------------------------------------------------------
Stefan Agner (2):
      clk: imx: return correct frequency for Ethernet PLL
      clk: imx7d: fix ahb clock mux 1

 drivers/clk/imx/clk-imx7d.c | 2 +-
 drivers/clk/imx/clk-pllv3.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)
