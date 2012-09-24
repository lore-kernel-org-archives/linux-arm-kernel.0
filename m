From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Sep 2012 16:46:08 +0100
Subject: [GIT PULL] Versatile Express clk
Message-ID: <1348501568.27071.5.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Would you be so kind and pull the VE clocking stuff? They are rebased on
top of Linus' Realview patch.

Thanks!

Pawel


The following changes since commit b9f8a0f8e255919bdcfb96a8d50d1523233a458a:

  clk: convert ARM RealView to common clk (2012-09-24 16:28:29 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git clk-v3.6-rc7

for you to fetch changes up to b262f1ed394218f9327b72e7d1d17a5e62074be0:

  clk: Common clocks implementation for Versatile Express (2012-09-24 16:28:30 +0100)

----------------------------------------------------------------
Pawel Moll (2):
      clk: Versatile Express clock generators ("osc") driver
      clk: Common clocks implementation for Versatile Express

 arch/arm/include/asm/hardware/sp810.h    |    2 +
 drivers/clk/Kconfig                      |    8 +-
 drivers/clk/versatile/Makefile           |    2 +
 drivers/clk/versatile/clk-vexpress-osc.c |  150 ++++++++++++++++++++++++++++++
 drivers/clk/versatile/clk-vexpress.c     |  142 ++++++++++++++++++++++++++++
 5 files changed, 301 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/versatile/clk-vexpress-osc.c
 create mode 100644 drivers/clk/versatile/clk-vexpress.c
