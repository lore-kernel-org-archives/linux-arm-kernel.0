From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 28 Apr 2014 10:49:40 -0000
Subject: [patch V2 0/6] dma: edma: Provide granular residue accounting
Message-ID: <20140428104416.464002156@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A simpler version to provide granular residue accounting and readout
for EDMA.

Delta to V1:

      - Removed the double read of the address in PaRAM

      - Simplified the stats update in the interrupt callback for
        intermediate transfers

Thanks,

	tglx
