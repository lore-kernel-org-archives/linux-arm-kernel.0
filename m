From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jul 2014 00:21:48 +0100
Subject: [PATCH A 00/12] Freescale ethernet driver updates
Message-ID: <20140707232148.GG21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

Here's the first batch of patches for the Freescale FEC ethernet driver.
They require the previously applied "net: fec: Don't clear IPV6 header
checksum field when IP accelerator enable" patch.

I'll mail further patches tomorrow, once I hear back from you.

Many thanks.

 drivers/net/ethernet/freescale/fec.h      |   1 -
 drivers/net/ethernet/freescale/fec_main.c | 137 +++++++++++++++++-------------
 2 files changed, 79 insertions(+), 59 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
