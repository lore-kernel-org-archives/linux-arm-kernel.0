From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 21 Oct 2013 12:56:12 +0530
Subject: [PATCH 1/3] dma: edma: Split out PaRAM set calculations into
 its own function
In-Reply-To: <1379977515-3794-2-git-send-email-joelf@ti.com>
References: <1379977515-3794-1-git-send-email-joelf@ti.com>
 <1379977515-3794-2-git-send-email-joelf@ti.com>
Message-ID: <20131021072612.GN14013@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 06:05:13PM -0500, Joel Fernandes wrote:
> PaRAM set calculation is abstracted into its own function to
> enable better reuse for other DMA cases such as cyclic. We adapt
> the Slave SG case to use the new function.
> 
> This provides a much cleaner abstraction to the internals of the
> PaRAM set. However, any PaRAM attributes that are not common to
> all DMA types must be set separately such as setting of interrupts.
> This function takes care of the most-common attributes.
> 
> Also added comments clarifying A-sync case calculations.
Applied, thanks

--
~Vinod
