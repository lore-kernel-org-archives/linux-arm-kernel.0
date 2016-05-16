From: horms@verge.net.au (Simon Horman)
Date: Mon, 16 May 2016 17:11:08 +0900
Subject: [PATCHv4 0/4] Reference both DMA controllers
In-Reply-To: <1463043285-14702-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1463043285-14702-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160516081108.GB4955@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 10:54:41AM +0200, Niklas S?derlund wrote:
> Hi,
> 
> R-Car Gen2 have two DMA controllers, which are equivalent. However DMA
> slaves were tied only to a single DMA controller in .dtsi. This series
> add references to to both DMA controllers for all nodes that previously
> only referenced one of them. It also adds dma references to the SDHI
> nodes for r8a7794 which according to the datasheet should work but I
> have not access to HW to verify.
> 
> Tested on Koelsch (r8a7791) by altering the compatible value of either
> dmac0 or dmac1 and verifying that the DMA slaves pick the DMA controller
> that is available.

Thanks, I have queued these up.
