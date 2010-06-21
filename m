From: lhrossouw@gmail.com (Lucas)
Date: Mon, 21 Jun 2010 14:30:56 +0000 (UTC)
Subject: [PATCH] Fix AT91SAM9G20 reset
References: <20100528153725.GA5102@axolotl.localnet>
Message-ID: <loom.20100621T162410-494@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Horton <phorton <at> bitbox.co.uk> writes:

> 
> Fix AT91SAM9G20 as per the errata in the datasheet.
> 
> If the SDRAM is not cleanly shutdown before reset it can be left driving
> the bus, which then stops the bootloader booting from NAND.
> 
> Signed-off-by: Peter Horton <phorton <at> bitbox.co.uk>
> --
> 


Hi Peter,

Any Idea how to implement this for the WDT and hardware reset(NRST)?
A hardware reset sometimes still stops the bootloader booting from NAND.

Lucas 
