From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 30 Jun 2010 20:20:52 +0200
Subject: [PATCH 08/33] Removing dead SA1101
In-Reply-To: <alpine.LFD.2.00.1006301255260.24097@xanadu.home>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<7488ec29cdb90212e965f6cd1173141c576c0955.1277911346.git.siccegge@cs.fau.de>
	<alpine.LFD.2.00.1006301255260.24097@xanadu.home>
Message-ID: <201006302020.52270.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 30. ?ervna 2010 18:57:43 Nicolas Pitre napsal(a):
> On Wed, 30 Jun 2010, Christoph Egger wrote:
> > SA1101 doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
> > 
> > Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> 
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

You're dropping support for a whole CPU here ... is the code redundant or 
something ?
> 
> > ---
> > 
> >  arch/arm/mach-sa1100/include/mach/SA-1101.h  |  925
> >  -------------------------- arch/arm/mach-sa1100/include/mach/hardware.h
> >  |    4 -
> >  2 files changed, 0 insertions(+), 929 deletions(-)
> >  delete mode 100644 arch/arm/mach-sa1100/include/mach/SA-1101.h
> 
> [...]
> 
> 
> Nicolas
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
