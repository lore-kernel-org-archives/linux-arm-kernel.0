From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2012 10:32:41 +0100
Subject: [RFC 00/12] OMAP DMA engine conversion
In-Reply-To: <1337072367.16185.5401.camel@vkoul-udesk3>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <1337055564.16185.5356.camel@vkoul-udesk3>
 <20120515074141.GA16276@n2100.arm.linux.org.uk>
 <1337072367.16185.5401.camel@vkoul-udesk3>
Message-ID: <20120515093241.GB16276@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 02:29:27PM +0530, Vinod Koul wrote:
> On Tue, 2012-05-15 at 08:41 +0100, Russell King - ARM Linux wrote:
> > It's not ready for merging.  While it allows some of the OMAP drivers
> > to be converted, there's others which need changes to omap-dma.c.
> > 
> > So, I'm _not_ planning to see this in for the upcoming merge window.
> Okay, Thanks for the update. I am waiting for the virtual channel
> support in this series.

It's changed a little since the last post to allow it to support the
tx_status semantics we discussed, and has some rudimentary and untested
cyclic support.

As we're in the final week before the merge window, and this stuff has
not had any time in linux-next, it's rather late to think about putting
it in for v3.5.
