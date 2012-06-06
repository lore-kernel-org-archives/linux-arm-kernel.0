From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 6 Jun 2012 14:41:29 +0530
Subject: [PATCH 0/2] some minor clk fixes
Message-ID: <1338973891-28719-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

These are a couple of fixes I found while testing my
OMAP clock port.

regards,
Rajendra

Rajendra Nayak (2):
  clk: cache parent clocks only for muxes
  clk: Allow late cache allocation for clk->parents

 drivers/clk/clk.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)
