From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Sep 2013 15:12:44 +0100
Subject: [PATCH 01/51] DMA-API: provide a helper to set both DMA and
 coherent DMA masks
In-Reply-To: <1379640097.2500.4.camel@bwh-desktop.uk.level5networks.com>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMlja-0007fA-HU@rmk-PC.arm.linux.org.uk>
 <1379640097.2500.4.camel@bwh-desktop.uk.level5networks.com>
Message-ID: <20130920141244.GQ25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 02:21:37AM +0100, Ben Hutchings wrote:
> On Thu, 2013-09-19 at 22:25 +0100, Russell King wrote:
> [...]
> > -dma_set_coherent_mask() will always be able to set the same or a
> > -smaller mask as dma_set_mask(). However for the rare case that a
> > +The coherent coherent mask will always be able to set the same or a
> > +smaller mask as the streaming mask. However for the rare case that a
> [...]
> 
> The new wording doesn't make sense; a mask doesn't set itself.  I would
> suggest:
> 
> "The coherent mask can always be set to the same or a smaller mask than
> the streaming mask."

Yes, the original sentence is not particularly good, but I think even
your modified version can be interpreted as "a mask setting itself"
for all the same reasons that the original can be (which mask does "same"
refer to?)

Even so, I prefer your version.  Thanks. :)
