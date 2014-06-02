From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jun 2014 17:06:02 +0200
Subject: [PATCH v3 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <538C7B22.2020107@ti.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <20140602063702.GB7834@dragon> <538C7B22.2020107@ti.com>
Message-ID: <4197388.OE67ahhtqp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 June 2014 09:24:50 Santosh Shilimkar wrote:
> On Monday 02 June 2014 02:37 AM, Shawn Guo wrote:
> > On Thu, Apr 24, 2014 at 11:30:00AM -0400, Santosh Shilimkar wrote:
> >> Here is an updated v3 of the series. Series introduces support for setting up
> >> dma parameters based on device tree properties like 'dma-ranges' and
> >> 'dma-coherent' and also update to ARM 32 bit port. Earlier version of the
> >> series can be found here [3], [2] and [1].
> > 
> > Are these two generic device tree properties documented somewhere under
> > Documentation/devicetree/bindings?
> > 
> These bindings have been already in use before this series. But looks like
> they have not been documented. I will do a patch to add description for those
> couple of parameters.

dma-ranges is part of ePAPR, and was documented in some ieee-1275 addenda
before that, but I agree it would be nice to have something in kernel as
well, at the minimum something pointing to the relevant documents.

	Arnd
