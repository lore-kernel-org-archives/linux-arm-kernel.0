From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Feb 2014 20:22:57 +0100
Subject: [RFC PATCH V3 1/4] pci: APM X-Gene PCIe controller driver
In-Reply-To: <20140203221559.GG2519@obsidianresearch.com>
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
 <4985267.LnsktRmabM@wuerfel> <20140203221559.GG2519@obsidianresearch.com>
Message-ID: <201402042022.57267.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 February 2014, Jason Gunthorpe wrote:
> On Mon, Feb 03, 2014 at 09:12:32PM +0100, Arnd Bergmann wrote:
> 
> > Are you sure that is true for the root bridge as well? I don't
> > remember the details, but I though that for the host bridge,
> > we don't actually look at the BARs at all.
> 
> That is right, but this isn't a host bridge device, it is a PCI-PCI
> bridge with root complex registers. The root complex bridge is not the
> same as the host bridge.
> 
> Unfortunately the implementation is non-conforming. :(

Ok, I see. I was probably asking the wrong question then earlier
when I tried to find out what this is.

	Arnd
