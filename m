From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 20 May 2014 16:03:25 +0200
Subject: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <20140520134942.GC9873@lunn.ch>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <1821771.zFvTDGF2Ae@amdc1032> <20140520134942.GC9873@lunn.ch>
Message-ID: <20140520140325.GA21579@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 03:49:42PM +0200, Andrew Lunn wrote:
> On Tue, May 20, 2014 at 02:34:20PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday, May 20, 2014 11:04:29 AM Antoine T?nart wrote:
> > > 
> > > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > > index 4906c27fa3bd..b31b1986fda4 100644
> > > --- a/drivers/phy/Kconfig
> > > +++ b/drivers/phy/Kconfig
> > > @@ -15,6 +15,11 @@ config GENERIC_PHY
> > >  	  phy users can obtain reference to the PHY. All the users of this
> > >  	  framework should select this config.
> > >  
> > > +config PHY_BERLIN_SATA
> > > +	bool
> > 
> > Is there any real reason why this cannot be tristate?
> 
> What we have seen with SATA drivers and phys, is there is link time
> breakage if the SATA driver is built in and the phy is modular.
> 
> Maybe this has been fixed now? 

Using tristate shouldn't be a problem. I compiled without the PHY
driver, no link issue.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
