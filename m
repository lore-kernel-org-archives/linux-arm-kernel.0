From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 11 Feb 2011 20:00:27 +0800
Subject: [PATCH 1/2] arm: mx50_rdp: add fec support
In-Reply-To: <20110211102459.GG27982@pengutronix.de>
References: <1297419731-16441-1-git-send-email-richard.zhao@freescale.com>
	<20110211102459.GG27982@pengutronix.de>
Message-ID: <20110211120027.GA1866@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 11:24:59AM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Feb 11, 2011 at 06:22:10PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > 
> > diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
> > index dedf7f2..505513c 100644
> > --- a/arch/arm/mach-mx5/board-mx50_rdp.c
> > +++ b/arch/arm/mach-mx5/board-mx50_rdp.c
> > @@ -40,6 +40,9 @@
> >  #define FEC_EN		IMX_GPIO_NR(6, 23)
> >  #define FEC_RESET_B	IMX_GPIO_NR(4, 12)
> >  
> > +#define FEC_EN		IMX_GPIO_NR(6, 23)
> > +#define FEC_RESET_B	IMX_GPIO_NR(4, 12)
> > +
> I think this is a left-over of a rebase.  The #defines are already
> present and they alone don't justify saying "add fec support".
Yes, Sorry for that. Please review the second patch.

Thanks
Richard
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
