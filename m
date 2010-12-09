From: simon@horms.net (Simon Horman)
Date: Thu, 9 Dec 2010 09:43:56 +0900
Subject: [PATCH] rfc v2: ARM: mach-shmobile: mackerel: Add zboot support
In-Reply-To: <20101209002512.GB13412@linux-sh.org>
References: <1291850087-11388-1-git-send-email-horms@verge.net.au>
	<20101209002512.GB13412@linux-sh.org>
Message-ID: <20101209004356.GA21650@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 09:25:12AM +0900, Paul Mundt wrote:
> On Thu, Dec 09, 2010 at 08:14:47AM +0900, Simon Horman wrote:
> > * Use head-mackerel.txt for Mackerel.
> >   head-ap4evb.txt was used by mistake.
> > 
> ...
> 
> > diff --git a/arch/arm/mach-shmobile/include/mach/zboot.h b/arch/arm/mach-shmobile/include/mach/zboot.h
> > index 3ad86b7..994b891 100644
> > --- a/arch/arm/mach-shmobile/include/mach/zboot.h
> > +++ b/arch/arm/mach-shmobile/include/mach/zboot.h
> > @@ -13,6 +13,9 @@
> >  #ifdef CONFIG_MACH_AP4EVB
> >  #define MACH_TYPE	MACH_TYPE_AP4EVB
> >  #include "mach/head-ap4evb.txt"
> > +#elif CONFIG_MACH_MACKEREL
> > +#define MACH_TYPE	MACH_TYPE_MACKEREL
> > +#include "mach/head-ap4evb.txt"
> >  #else
> >  #error "unsupported board."
> >  #endif
> 
> Looks like it still does?

oops
