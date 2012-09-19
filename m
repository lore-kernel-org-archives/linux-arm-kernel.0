From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 14:50:40 +0000
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <20120919144040.GC16522@beef>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <5059D874.6040107@gmail.com> <20120919144040.GC16522@beef>
Message-ID: <201209191450.40360.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 September 2012, Matt Porter wrote:
> On Wed, Sep 19, 2012 at 09:36:36AM -0500, Rob Herring wrote:
> > On 09/19/2012 09:24 AM, Arnd Bergmann wrote:
> > > On Wednesday 19 September 2012, Matt Porter wrote:
> > >>> +Optional properties:
> > >>> +- #dma-channels:     Number of DMA channels supported by the controller.
> > >>> +- #dma-requests:     Number of DMA requests signals supported by the
> > >>> +                     controller.
> > >>
> > >> Shouldn't these two optional properties drop the prefix #?  By
> > >> convention adopted from the various original OF/ePAPR/etc specs, the
> > >> only properties I would expect to see with this prefix are the
> > >> "*-cells" cell sizes. A quick search indicates this is the case
> > >> throughout all the current bindings.
> > > 
> > > I always assumed that the # prefix is used to indicate that we are counting
> > > things instead of listing them.
> > 
> > Lots of properties count things, but don't have a #. nr_gpios or spi
> > chipselect counts for example. I'd say drop the #.
> 
> Ok, I can drop another trivial patch since I hear Jon is on vacation.
> 
> Yeah, I grepped all the bindings and it's only ever encountered on cell
> sizes. There's not even one example of it used as above.

Ok, sounds good.

	Arnd
