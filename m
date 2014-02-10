From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 15:55:31 +0000
Subject: [PATCH 00/26] OMAP dma engine rework
Message-ID: <20140210155531.GB26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the current set of patches for the OMAP DMA engine rework,
which should now work correctly on OMAP1 platforms thanks to Tony's
testing.

It would be good to get this validated by others across a range of
OMAP platforms, and queued up for the next merge window, so it can
be built upon.

Acks appreciated, and once sufficient have been added, I'll send a
pull request for this to Vinod.

 arch/arm/mach-omap1/dma.c | 191 ++++++--------
 arch/arm/mach-omap2/dma.c | 183 ++++++-------
 arch/arm/plat-omap/dma.c  |  17 +-
 drivers/dma/omap-dma.c    | 659 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/omap-dma.h  |  25 +-
 5 files changed, 784 insertions(+), 291 deletions(-)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
