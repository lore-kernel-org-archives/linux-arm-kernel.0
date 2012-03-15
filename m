From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Mar 2012 17:35:08 +0000
Subject: [PATCH 5/5] MMC: mmci: Add required documentation for Device
 Tree bindings
In-Reply-To: <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20120315173508.GE15988@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 02:20:03PM +0000, Lee Jones wrote:
> +ux500 variant specific properties:
> +- gpio-en                : contains the level-shifter enable gpio
> +- gpio-vsel              : contains the level-shifter voltage select gpio
> +- tx_dst_dev_type        : contains the tx destination device (DMA) 
> +- rx_src_dev_type        : contains the rx source device (DMA)

So what about the DMA support being proposed elsewhere?

This sounds like we're inventing one DMA solution for one bit of the tree
and another DMA solution for another bit.  This is madness.

Note that ARM boards like Versatile also have DMA support, even though
most of those platforms are diabolically crippled to the point of it being
useless.  I believe it works on a few select boards...
