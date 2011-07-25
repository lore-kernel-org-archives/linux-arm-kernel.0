From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 16:47:39 +0100
Subject: [PATCH] dmaengine: add helper function for slave_single
In-Reply-To: <1311608235.8206.24.camel@vkoul-mobl4>
References: <1311608235.8206.24.camel@vkoul-mobl4>
Message-ID: <20110725154739.GD14955@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 09:07:15PM +0530, Vinod Koul wrote:
> >From af9afd16e9954edb45f0cf71834653133d75e79c Mon Sep 17 00:00:00 2001
> From: Vinod Koul <vinod.koul@intel.com>
> Date: Mon, 25 Jul 2011 19:57:52 +0530
> Subject: [PATCH] dmaengine: add helper function for slave_single
> 
> For clients which require a single slave transfer and dont want to be bothered
> about the scatterlist api, this helper gives simple API for this transfer and
> creates single scatterlist for DMA API
> 
> Idea from Russel King

Please correct this, thanks.
