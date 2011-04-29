From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 29 Apr 2011 12:56:13 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104291326.25634.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
	<20110428093039.GU17290@n2100.arm.linux.org.uk>
	<1304024836.2513.198.camel@pasglop>
	<201104291326.25634.arnd@arndb.de>
Message-ID: <20110429125613.616f977b@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I believe that the PC graphics cards that have noncoherent DMA mappings
> are all of the unified memory (integrated into the northbridge) kind,
> so they are not on the same host bridge as all regular PCI devices,
> even if they appear as a PCI device.

The AGP GART is not coherent on a lot of systems - not necessarily
unified memory though, it can be a plug in AGP card too.
The GART is basically an IOMMU (and indeed in the later AMD case used
exactly as that)
