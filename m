From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Aug 2018 23:26:44 +0800
Subject: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
In-Reply-To: <20180810151341.GA6863@e107981-ln.cambridge.arm.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
 <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
 <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
 <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
 <efd9c1d560cae84e2a4ee7585a4c61d5d40ba755.camel@nxp.com>
 <20180808152741.GA31808@e107981-ln.cambridge.arm.com>
 <52ee6376fa15d3a9a62bcfa5d87173e454ccc024.camel@nxp.com>
 <20180810151341.GA6863@e107981-ln.cambridge.arm.com>
Message-ID: <20180821152643.GC32159@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 04:13:41PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Aug 10, 2018 at 11:11:55AM +0000, Leonard Crestez wrote:
> 
> [...]
> 
> > This needs further clarification: without the reset patch this will
> > hang on imx7 suspend/resume but this is the current behavior anyway.
> > 
> > Both patches are required for imx7 pci suspend and including them out
> > of order shouldn't break unrelated functionality.
> > 
> > So it should actually be fine to just include the pci changes now,
> > right?
> 
> It is a bit late for v4.19 but before considering that, this series
> is actually a set of fixes, correct ? If that's the case I think
> Shawn can send them upstream for a v4.19-rc*, I can ACK them if that
> sounds reasonable.
> 
> Patch (2) subject must make clear you are actually fixing a problem if
> we choose this course of action.

This is something never worked before, so it's a new feature to me.
That said, I'm not in the position to send the PCI patch for 4.19-rc as
a fix though IMX (arm-soc) tree.

I will send the DTS patch for 4.19-rc inclusion though, since that's
indeed a fix.

Shawn
