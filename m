From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 15:26:17 +0000
Subject: [PATCH V5 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1347635923-30166-2-git-send-email-jon-hunter@ti.com>
References: <1347635923-30166-1-git-send-email-jon-hunter@ti.com>
 <1347635923-30166-2-git-send-email-jon-hunter@ti.com>
Message-ID: <201209141526.17791.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Jon Hunter wrote:
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
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for all this work, looks great!

My final (tiny) comment on this:

> +2. A single read-write channel with two alternative dma controllers:
> +
> +	dmas = <&dma1 5
> +		&dma2 7
> +		&dma3 2>;
> +	dma-names = "rx-tx", "rx-tx", "rx-tx"

*three* alternative dma controllers, not two.

	Arnd
