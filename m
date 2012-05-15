From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 15 May 2012 15:25:54 -0400 (EDT)
Subject: [GIT PULL] ARM: Kirkwood: new boards for v3.5
In-Reply-To: <4FB2181F.7010609@codethink.co.uk>
References: <20120515032605.GV16338@titan.lakedaemon.net>
 <4FB2181F.7010609@codethink.co.uk>
Message-ID: <alpine.LFD.2.02.1205151521310.1640@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2012, Ben Dooks wrote:

> On 15/05/12 04:26, Jason Cooper wrote:
> >   .../devicetree/bindings/mtd/orion-nand.txt         |   50 ++++
> >   arch/arm/boot/dts/kirkwood-dns320.dts              |   64 +++++
> >   arch/arm/boot/dts/kirkwood-dns325.dts              |   59 +++++
> >   arch/arm/boot/dts/kirkwood-ib62x0.dts              |   44 +++
> >   arch/arm/boot/dts/kirkwood-iconnect.dts            |   26 ++
> 
> I thought the idea of going to device-tree was to remove the addition
> of these? Now instead of .c files we're getting piles of .dts files.

Yes, and this is a good thing.

We're not to that point where DT is sufficiently well implemented and 
stable on ARM for those files to live somewhere else.  Eventually they 
will go when they won't have to evolve in lock step anymore.


Nicolas
