From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 1 Jul 2010 02:01:05 +0200
Subject: [PATCH 08/33] Removing dead SA1101
In-Reply-To: <alpine.LFD.2.00.1006301453450.24097@xanadu.home>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<201006302020.52270.marek.vasut@gmail.com>
	<alpine.LFD.2.00.1006301453450.24097@xanadu.home>
Message-ID: <201007010201.05424.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 30. ?ervna 2010 20:59:05 Nicolas Pitre napsal(a):
> On Wed, 30 Jun 2010, Marek Vasut wrote:
> > Dne St 30. ?ervna 2010 18:57:43 Nicolas Pitre napsal(a):
> > > On Wed, 30 Jun 2010, Christoph Egger wrote:
> > > > SA1101 doesn't exist in Kconfig, therefore removing all
> > > > references for it from the source code.
> > > > 
> > > > Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> > > 
> > > Acked-by: Nicolas Pitre <nico@fluxnic.net>
> > 
> > You're dropping support for a whole CPU here ... is the code redundant or
> > something ?
> 
> The SA1101 is not a CPU.  It is a companion chipset for the SA1100.  And
> so far we have no target using it in the tree, and that isn't likely to
> change more than 10 years after the chip availability.  Needless to say
> that the SA1101 has long been unavailable either.
> 
> We also have support for the SA1111 which is a similar companion chipset
> for the SA1110.  This is not going away as at least the Neponset
> expansion board for the Assabet development board is using a SA1111.
> 
> 
> Nicolas

Oh I see. Thanks for clearing that.
