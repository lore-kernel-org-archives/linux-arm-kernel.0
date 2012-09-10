From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 10 Sep 2012 13:57:57 -0400 (EDT)
Subject: [PATCH v3 31/31] arm64: MAINTAINERS update
In-Reply-To: <20120909163156.GA31430@game.jcrosoft.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-32-git-send-email-catalin.marinas@arm.com>
 <20120909163156.GA31430@game.jcrosoft.org>
Message-ID: <alpine.LFD.2.02.1209101355000.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Sep 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:

> On 17:27 Fri 07 Sep     , Catalin Marinas wrote:
> > This patch updates the MAINTAINERS file for the AArch64 Linux kernel
> > port.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  MAINTAINERS |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fdc0119..de368a5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1209,6 +1209,12 @@ S:	Maintained
> >  F:	arch/arm/mach-pxa/z2.c
> >  F:	arch/arm/mach-pxa/include/mach/z2.h
> >  
> > +ARM64 PORT (AARCH64 ARCHITECTURE)
> > +M:	Catalin Marinas <catalin.marinas@arm.com>
> we should put Russell too

He is not maintaining the ARM64 code.


Nicolas
