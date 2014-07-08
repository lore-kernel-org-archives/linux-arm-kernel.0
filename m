From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jul 2014 12:39:11 +0100
Subject: [PATCH B 00/10] Freescale ethernet driver updates (part 2)
Message-ID: <20140708113911.GH21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

Here's the second batch of patches for the Freescale FEC ethernet driver,
based upon the previous set of patches.  One further set of 7 patches
remains.

Many thanks.

 drivers/net/ethernet/freescale/fec_main.c | 127 ++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 43 deletions(-)
