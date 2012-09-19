From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 14:24:55 +0000
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <20120919140705.GB16522@beef>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
 <20120919140705.GB16522@beef>
Message-ID: <201209191424.56086.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 September 2012, Matt Porter wrote:
> > +Optional properties:
> > +- #dma-channels:     Number of DMA channels supported by the controller.
> > +- #dma-requests:     Number of DMA requests signals supported by the
> > +                     controller.
> 
> Shouldn't these two optional properties drop the prefix #?  By
> convention adopted from the various original OF/ePAPR/etc specs, the
> only properties I would expect to see with this prefix are the
> "*-cells" cell sizes. A quick search indicates this is the case
> throughout all the current bindings.

I always assumed that the # prefix is used to indicate that we are counting
things instead of listing them.

	Arnd
