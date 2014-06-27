From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jun 2014 15:16:28 +0200
Subject: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <20140627124949.GR26276@arm.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <6381366.2IfqZj1r0B@wuerfel> <20140627124949.GR26276@arm.com>
Message-ID: <7528887.J1DnSBg239@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 June 2014 13:49:49 Will Deacon wrote:
> On Fri, Jun 27, 2014 at 12:03:34PM +0100, Arnd Bergmann wrote:
> > On Thursday 26 June 2014 19:44:21 Rob Herring wrote:
> > > I don't agree arm32 is harder than microblaze. Yes, converting ALL of
> > > arm would be, but that is not necessary. With Liviu's latest branch
> > > the hacks I previously needed are gone (thanks!), and this is all I
> > > need to get Versatile PCI working (under QEMU):
> > 
> > I meant converting all of arm32 would be harder, but I agree we don't
> > have to do it. It would be nice to convert all of the drivers/pci/host
> > drivers though, iow all multiplatform-enabled ones, and leaving the
> > current arm32 pci implementation for the platforms we don't want to
> > convert to multiplatform anyway (footbridge, iop, ixp4xx, ks8695 (?),
> > pxa, sa1100).
> 
> I'm more than happy to convert the generic host controller we merged
> recently, but I'd probably want the core changes merged first so that I
> know I'm not wasting my time!

That is definitely fine with me, but it's Bjorn's decision.

	Arnd
