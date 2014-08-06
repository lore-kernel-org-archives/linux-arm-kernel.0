From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Wed, 6 Aug 2014 16:35:12 +0800
Subject: [PATCH V2 0/3] refine clock tree for esai in imx6q
Message-ID: <cover.1407313676.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

refine clock tree for esai in imx6q

Changes for V2
- Add pll5_sel And update the comments for patch 2.
- As the bypass mode is not supported in clk tree, so update the 
- comments for patch 3.

Shengjiu Wang (3):
  ARM: clk-imx6q: refine clock tree for ESAI
  ARM: clk-imx6q: Add missing lvds and anaclk clock to the clock tree
  ARM: imx6q: Add the clock route from external OSC to ESAI clock

 arch/arm/mach-imx/clk-imx6q.c             |   24 +++++++++++++++++++-----
 arch/arm/mach-imx/mach-imx6q.c            |   28 ++++++++++++++++++++++++++++
 include/dt-bindings/clock/imx6qdl-clock.h |   13 ++++++++++---
 3 files changed, 57 insertions(+), 8 deletions(-)

-- 
1.7.9.5
