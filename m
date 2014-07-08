From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jul 2014 13:01:17 +0100
Subject: [PATCH C 0/7] Freescale ethernet driver updates (part 3)
Message-ID: <20140708120117.GJ21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

Here's the third batch of patches for the Freescale FEC ethernet driver,
based upon the previous set of patches.  This concludes the changes I
currently have prepared and have been reviewed for the next merge window
at this time.

Many thanks.

 drivers/net/ethernet/freescale/fec.h      |   9 +-
 drivers/net/ethernet/freescale/fec_main.c | 139 ++++++++++++++----------------
 2 files changed, 68 insertions(+), 80 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
