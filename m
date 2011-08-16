From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Aug 2011 15:56:35 +0200
Subject: [GIT PULL] dmaengine: at_hdmac fixes for next
Message-ID: <4E4A7713.1070902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

Please pull from:

  git://github.com/at91linux/linux-2.6-at91.git nfe/sdma_at_hdmac

to receive latest updates for the Atmel at_hdmac dmaengine driver. Those changes are made on top of current linus' git tree (v3.1-rc2-59-g5bad33c).
The patches below have been discussed on the linux-arm-kernel mailing-list.

Thanks,

Nicolas Ferre (4):
      dmaengine: at_hdmac: replace spin_lock* with irqsave variants
      dmaengine: at_hdmac: improve power management routines
      dmaengine: at_hdmac: add wrappers for testing channel state
      dmaengine: at_hdmac: fix way to specify cyclic capability

 drivers/dma/at_hdmac.c      |  159 +++++++++++++++++++++++++++++++++---------
 drivers/dma/at_hdmac_regs.h |   24 +++++++
 2 files changed, 149 insertions(+), 34 deletions(-)

-- 
Nicolas Ferre
