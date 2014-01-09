From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 9 Jan 2014 12:15:16 +0000
Subject: [PATCH v8 4/6] arm64: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <20140109121308.GH3081@arm.com>
References: <alpine.DEB.2.02.1401081845040.21510@kaball.uk.xensource.com>
 <1389206998-27875-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <20140109121308.GH3081@arm.com>
Message-ID: <1389269716.27473.73.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-09 at 12:13 +0000, Catalin Marinas wrote:
> On Wed, Jan 08, 2014 at 06:49:56PM +0000, Stefano Stabellini wrote:
> >  arch/arm64/Kconfig         |   20 ++++++++++++++++++++
> >  arch/arm64/kernel/Makefile |    1 +
> >  2 files changed, 21 insertions(+)
> [...]
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 5ba2fd4..1dee735 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -18,6 +18,7 @@ arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o
> >  arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
> >  arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
> >  arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
> > +arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
> 
> Did you forget a git add?

I was just about to say the same thing for the previous arm patch too.

Ian.
