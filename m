From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jun 2012 11:34:34 +0100
Subject: [CFT] DMA engine patches
Message-ID: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am intending to post the _entire_ set of DMA patches I have so far.
I'm going to be doing this in a slightly different way to normal,
because of the way the branches are structured.

What will come first is a set of three common patches to all the
branches.  Following on from that will be the individual sets for
sa11x0, pl08x and OMAP.

These are for testing, and are based on v3.5-rc1.

 drivers/dma/Kconfig      |    4 +
 drivers/dma/Makefile     |    1 +
 drivers/dma/sa11x0-dma.c |  249 ++++++++++++++-------------------------------
 drivers/dma/virt-dma.c   |  123 +++++++++++++++++++++++
 drivers/dma/virt-dma.h   |  152 ++++++++++++++++++++++++++++
 5 files changed, 358 insertions(+), 171 deletions(-)
