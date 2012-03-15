From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 17:49:07 +0000
Subject: [PATCH 5/5] MMC: mmci: Add required documentation for Device Tree
 bindings
In-Reply-To: <20120315173508.GE15988@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
 <20120315173508.GE15988@n2100.arm.linux.org.uk>
Message-ID: <201203151749.07673.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> 
> On Wed, Mar 14, 2012 at 02:20:03PM +0000, Lee Jones wrote:
> > +ux500 variant specific properties:
> > +- gpio-en                : contains the level-shifter enable gpio
> > +- gpio-vsel              : contains the level-shifter voltage select gpio
> > +- tx_dst_dev_type        : contains the tx destination device (DMA) 
> > +- rx_src_dev_type        : contains the rx source device (DMA)
> 
> So what about the DMA support being proposed elsewhere?
> 
> This sounds like we're inventing one DMA solution for one bit of the tree
> and another DMA solution for another bit.  This is madness.

Agreed. I originally made a similar comment for an early version but had not
noticed that it made it into this one. This should be using the proper DMA
bindings, or just auxdata while we're not entirely there yet.

	Arnd
