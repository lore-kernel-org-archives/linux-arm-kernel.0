From: joelf@ti.com (Joel Fernandes)
Date: Mon, 28 Apr 2014 15:47:37 -0500
Subject: [patch V2 0/6] dma: edma: Provide granular residue accounting
In-Reply-To: <20140428104416.464002156@linutronix.de>
References: <20140428104416.464002156@linutronix.de>
Message-ID: <535EBE69.6060803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 05:49 AM, Thomas Gleixner wrote:
> A simpler version to provide granular residue accounting and readout
> for EDMA.
> 
> Delta to V1:
> 
>       - Removed the double read of the address in PaRAM
> 
>       - Simplified the stats update in the interrupt callback for
>         intermediate transfers
> 
> Thanks,
> 
> 	tglx
> 

Thanks for the series. I went over all the patches and it looks great.
Acked-by: Joel Fernandes <joelf@ti.com>

The patches however didn't apply and had some conflicts with my dma
memcpy series and peter's cyclic series so I resolved conflicts and
created a single branch based on Vinod's slave-dma next branch (commit
406efb1a745c1dc512dc9c3c859e302e7b7f907e) that Vinod can pull.

I also renamed subject line of patches in Thomas's series to be
"dmaengine: edma" and documented some of the variables used.

https://github.com/joelagnel/linux-kernel.git (for-vinod branch)

Vinod, could you pull if it looks OK?

regards,
-Joel
