From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jun 2012 11:42:06 +0100
Subject: [CFT] SA11x0 patches
In-Reply-To: <E1Sca9b-0003ax-4E@rmk-PC.arm.linux.org.uk>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Message-ID: <20120607104206.GA10488@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates to the SA11x0 DMA engine driver.  This fixes the residue
calculation, and implements cyclic transfers.

 drivers/dma/sa11x0-dma.c |  153 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 121 insertions(+), 32 deletions(-)
