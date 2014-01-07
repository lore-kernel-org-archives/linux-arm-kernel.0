From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 07 Jan 2014 10:54:41 +0100
Subject: [PATCH 15/15] sh: intc: Enable driver compilation with
 COMPILE_TEST
In-Reply-To: <3670569.dVXQxeaJBM@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <3670569.dVXQxeaJBM@avalon>
Message-ID: <2305561.CqXvNryyXG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013 13:52:31 Laurent Pinchart wrote:
> Hi Magnus,
> 
> Could you tell me who is responsible for merging drivers/sh patches ? If
> that's one of you, could you please pick this patch up for v3.14 ?

Ping ?

> On Wednesday 27 November 2013 02:18:37 Laurent Pinchart wrote:
> > This helps increasing build testing coverage.
> > 
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/sh/intc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/sh/intc/Kconfig b/drivers/sh/intc/Kconfig
> > index a305731..f7d9061 100644
> > --- a/drivers/sh/intc/Kconfig
> > +++ b/drivers/sh/intc/Kconfig
> > @@ -6,7 +6,7 @@ comment "Interrupt controller options"
> > 
> >  config INTC_USERIMASK
> >  
> >  	bool "Userspace interrupt masking support"
> > 
> > -	depends on ARCH_SHMOBILE || (SUPERH && CPU_SH4A)
> > +	depends on ARCH_SHMOBILE || (SUPERH && CPU_SH4A) || COMPILE_TEST
> > 
> >  	help
> >  	
> >  	  This enables support for hardware-assisted userspace hardirq
> >  	  masking.

-- 
Regards,

Laurent Pinchart
