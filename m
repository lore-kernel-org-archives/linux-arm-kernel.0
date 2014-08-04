From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Mon, 4 Aug 2014 19:11:12 +0800
Subject: [PATCH V1 0/3] refine clock tree for esai in imx6q
Message-ID: <cover.1407148853.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series refine the clock tree for esai in imx6q

Shengjiu Wang (3):
  ARM: clk-imx6q: refine clock tree for ESAI
  ARM: clk-imx6q: Add missing lvds2 clock to the clock tree
  ARM: imx6q: Add the clock route from external OSC to ESAI clock

 arch/arm/mach-imx/clk-imx6q.c             |   21 +++++++++++++++++----
 arch/arm/mach-imx/mach-imx6q.c            |   28 ++++++++++++++++++++++++++++
 include/dt-bindings/clock/imx6qdl-clock.h |   12 +++++++++---
 3 files changed, 54 insertions(+), 7 deletions(-)

-- 
1.7.9.5
