From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 15:26:35 +0000
Subject: [PATCH V5 2/2] dmaengine: add helper function to request a slave
 DMA channel
In-Reply-To: <1347635923-30166-3-git-send-email-jon-hunter@ti.com>
References: <1347635923-30166-1-git-send-email-jon-hunter@ti.com>
 <1347635923-30166-3-git-send-email-jon-hunter@ti.com>
Message-ID: <201209141526.36088.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Jon Hunter wrote:
> Currently slave DMA channels are requested by calling dma_request_channel()
> and requires DMA clients to pass various filter parameters to obtain the
> appropriate channel.
> 
> With device-tree being used by architectures such as arm and the addition of
> device-tree helper functions to extract the relevant DMA client information
> from device-tree, add a new function to request a slave DMA channel using
> device-tree. This function is currently a simple wrapper that calls the
> device-tree of_dma_request_slave_channel() function.
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
