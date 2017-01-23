From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 13:48:25 +0100
Subject: [PATCH 0/2] clk: mediatek: add missing ethernet reset definition
Message-ID: <1485175707-58528-1-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the clk code for mt2701 was merged, we forgot to add the reset
controller of the ethernet subsystem. This series adds the missing code
and header files required to reference the bits from within a devicetree
file.

John Crispin (2):
  clk: mediatek: add mt2701 ethernet reset
  reset: mediatek: Add MT2701 ethsys reset controller include file

 drivers/clk/mediatek/clk-mt2701-eth.c     |    2 ++
 include/dt-bindings/reset/mt2701-resets.h |    7 +++++++
 2 files changed, 9 insertions(+)

-- 
1.7.10.4
