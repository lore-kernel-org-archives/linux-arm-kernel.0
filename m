From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 8 Apr 2013 11:03:10 -0600
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <201304061039.56241.arnd@arndb.de>
References: <20130405150200.7b6dee63@skate> <201304052301.27231.arnd@arndb.de>
 <20130405212143.GA16221@obsidianresearch.com>
 <201304061039.56241.arnd@arndb.de>
Message-ID: <20130408170310.GB30824@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 06, 2013 at 10:39:56AM +0200, Arnd Bergmann wrote:

> > Realistically this size should never be used so it doesn't matter if
> > it is 4G or 4G-1 - though obviously 4G is preferred in cases where
> > size cells is 2. :)
> 
> But the PCI bus already is required to have #size-cells=<2>, and
> we would only use this in the ranges property of the PCI node, right?

Yes, my bad, you are correct.

> > So.. I don't think it matters today for mvebu, but something to think
> > about - shuffling the firmware's address map could be dangerous.
> 
> I would at least expect a secure-mode firmware to prevent the OS
> from changing any mappings that the firmware relies on, but I see
> what you mean.

Right.

Jason
