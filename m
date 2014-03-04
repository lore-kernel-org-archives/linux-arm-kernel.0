From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 04 Mar 2014 19:19:34 +0100
Subject: [PATCH 10/15] irda: sh_irda: Enable driver compilation with
 COMPILE_TEST
In-Reply-To: <63153015.VK19yFZrrS@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2434798.8bvsZzgdNb@avalon> <63153015.VK19yFZrrS@avalon>
Message-ID: <4876025.BhmDicoI5K@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Tuesday 07 January 2014 16:13:49 Laurent Pinchart wrote:
> On Wednesday 11 December 2013 13:49:15 Laurent Pinchart wrote:
> > Hi Samuel,
> > 
> > Could you please pick this patch up for v3.14 ?
> 
> Ping ?

PING ?

> > On Wednesday 27 November 2013 02:18:32 Laurent Pinchart wrote:
> > > This helps increasing build testing coverage.
> > > 
> > > Cc: Samuel Ortiz <samuel@sortiz.org>
> > > Cc: netdev at vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > Acked-by: Simon Horman <horms@verge.net.au>
> > > ---
> > > 
> > >  drivers/net/irda/Kconfig | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
> > > index 2a30193..cae5ee2 100644
> > > --- a/drivers/net/irda/Kconfig
> > > +++ b/drivers/net/irda/Kconfig
> > > @@ -403,7 +403,8 @@ config MCS_FIR
> > > 
> > >  config SH_IRDA
> > >  
> > >  	tristate "SuperH IrDA driver"
> > > 
> > > -	depends on IRDA && ARCH_SHMOBILE
> > > +	depends on IRDA
> > > +	depends on ARCH_SHMOBILE || COMPILE_TEST
> > > 
> > >  	help
> > >  	
> > >  	  Say Y here if your want to enable SuperH IrDA devices.

-- 
Regards,

Laurent Pinchart
