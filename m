From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 16 Aug 2016 14:02:57 +0000
Subject: [PATCH] net: phy: Update copyright info
In-Reply-To: <20160816133057.GG14446@lunn.ch>
References: <1471328909-20104-1-git-send-email-appanad@xilinx.com>
 <20160816133057.GG14446@lunn.ch>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5E2C32@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

> 
> On Tue, Aug 16, 2016 at 11:58:29AM +0530, Kedareswara rao Appana wrote:
> > For implementing this driver most of the inputs is provided by Andrew
> > Lunn.
> >
> > Updating the driver with Andrew Copy right.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> 
> O.K, so this is a start in correcting the damage.
> 
> The code still has major issues, like i think it will Opps after you unload the
> module. The code was not ready for merging, which is why it did not get my
> Signed-off-by, when i left for vacation...
> 
> So, for this, and only this patch:
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Thanks...

Will test the driver as a module and will fix the Opps that you are taking will post the patch...

Regards,
Kedar.

> 
>     Andrew
> 
> 
> 
> > ---
> >  drivers/net/phy/xilinx_gmii2rgmii.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c
> > b/drivers/net/phy/xilinx_gmii2rgmii.c
> > index cad6e19..e7a20ec 100644
> > --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> > +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> > @@ -1,7 +1,9 @@
> >  /* Xilinx GMII2RGMII Converter driver
> >   *
> >   * Copyright (C) 2016 Xilinx, Inc.
> > + * Copyright (C) 2016 Andrew Lunn <andrew@lunn.ch>
> >   *
> > + * Author: Andrew Lunn <andrew@lunn.ch>
> >   * Author: Kedareswara rao Appana <appanad@xilinx.com>
> >   *
> >   * Description:
> > --
> > 2.1.2
> >
