From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 17 May 2012 15:52:12 +0530
Subject: [PATCH 0/2] clk: Add support for more default divider types
Message-ID: <1337250134-29206-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

The 2 patches here add support for 'power of two' and 'table based'
dividers to clk-divider.c.
These divider types are useful on OMAP and extending clk-divider.c
to support these should help other platforms too which have
such divider types.

regards,
Rajendra

Rajendra Nayak (2):
  clk: Add support for power of two type dividers
  clk: Add support for rate table based dividers

 drivers/clk/clk-divider.c    |  129 +++++++++++++++++++++++++++++++++++-------
 include/linux/clk-private.h  |    3 +-
 include/linux/clk-provider.h |   10 +++-
 3 files changed, 120 insertions(+), 22 deletions(-)
