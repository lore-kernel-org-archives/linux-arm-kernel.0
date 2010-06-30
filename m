From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 30 Jun 2010 14:59:05 -0400 (EDT)
Subject: [PATCH 08/33] Removing dead SA1101
In-Reply-To: <201006302020.52270.marek.vasut@gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<7488ec29cdb90212e965f6cd1173141c576c0955.1277911346.git.siccegge@cs.fau.de>
	<alpine.LFD.2.00.1006301255260.24097@xanadu.home>
	<201006302020.52270.marek.vasut@gmail.com>
Message-ID: <alpine.LFD.2.00.1006301453450.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jun 2010, Marek Vasut wrote:

> Dne St 30. ?ervna 2010 18:57:43 Nicolas Pitre napsal(a):
> > On Wed, 30 Jun 2010, Christoph Egger wrote:
> > > SA1101 doesn't exist in Kconfig, therefore removing all
> > > references for it from the source code.
> > > 
> > > Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> > 
> > Acked-by: Nicolas Pitre <nico@fluxnic.net>
> 
> You're dropping support for a whole CPU here ... is the code redundant or 
> something ?

The SA1101 is not a CPU.  It is a companion chipset for the SA1100.  And 
so far we have no target using it in the tree, and that isn't likely to 
change more than 10 years after the chip availability.  Needless to say 
that the SA1101 has long been unavailable either.

We also have support for the SA1111 which is a similar companion chipset 
for the SA1110.  This is not going away as at least the Neponset 
expansion board for the Assabet development board is using a SA1111.


Nicolas
