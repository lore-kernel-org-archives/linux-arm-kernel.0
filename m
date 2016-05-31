From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 31 May 2016 09:47:45 +0200
Subject: [PATCH RFC 0/2] clk: sunxi-ng: Add the A83T clocks
Message-ID: <cover.1464680865.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a proposal to add the clocks of the sunxi A83T
in the "modern" clock framework proposed by Maxime Ripard.
It is currently being tested on a Banana Pi M3.

Jean-Francois Moine (2):
  clk: sunxi: Add the PLL clocks of the A83T and A80 SoCs
  clk: sunxi-ng: Add the A83T clocks

 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c  | 755 +++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_ndmp.c        | 247 +++++++++++
 drivers/clk/sunxi-ng/ccu_ndmp.h        |  45 ++
 include/dt-bindings/clock/sun8i-a83t.h | 150 +++++++
 include/dt-bindings/reset/sun8i-a83t.h |  96 +++++
 5 files changed, 1293 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.h
 create mode 100644 include/dt-bindings/clock/sun8i-a83t.h
 create mode 100644 include/dt-bindings/reset/sun8i-a83t.h

-- 
2.8.3
