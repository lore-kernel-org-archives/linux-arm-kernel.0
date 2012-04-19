From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 19 Apr 2012 21:42:47 +0300
Subject: [PATCH v2] dmaengine/ep93xx_dma: Implement double buffering for
 M2M DMA channels
In-Reply-To: <4F8FD884.7090403@metasoft.pl>
References: <4F8FD884.7090403@metasoft.pl>
Message-ID: <20120419184247.GA877@mwesterb-mobl.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 11:19:00AM +0200, Rafal Prylowski wrote:
> Add double buffering support for M2M DMA channels. Implement this by using EP93xx
> M2M DMA Buffer and Control Finite State Machines to be sure that we are not
> disabling the channel when it's actually operating.
> 
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
