From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Feb 2018 16:44:17 +0100
Subject: [PATCH 0/5] soc: renesas: dd symbols for R-Car Gen3 register offsets
Message-ID: <20180212154422.13900-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and use symbols for Gen3 register offsets to improve readability.

This has no functional change.

Based on renesas-devel-20180212-v4.16-rc1.

Simon Horman (5):
  soc: renesas: Add symbols for R-Car Gen3 register offsets
  soc: renesas: Use symbols for register offsets for R-Car H3 power
    areas
  soc: renesas: Use symbols for register offsets for R-Car M3-W power
    areas
  soc: renesas: Use symbols for register offsets for R-Car V3M power
    areas
  soc: renesas: Use symbols for register offsets for R-Car D3 power
    areas

 drivers/soc/renesas/r8a7795-sysc.c  | 76 +++++++++++++++++++++----------------
 drivers/soc/renesas/r8a7796-sysc.c  | 56 +++++++++++++++------------
 drivers/soc/renesas/r8a77970-sysc.c | 39 +++++++++++--------
 drivers/soc/renesas/r8a77995-sysc.c | 11 +++---
 drivers/soc/renesas/rcar-sysc.h     | 19 ++++++++++
 5 files changed, 125 insertions(+), 76 deletions(-)

-- 
2.11.0
