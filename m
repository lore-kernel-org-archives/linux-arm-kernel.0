From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 09:18:04 -0800
Subject: [PATCH 3/3] drivers: bus: Move omap gpmc code to live under
 drivers
In-Reply-To: <546EF266.1010901@ti.com>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
 <1416522501-14999-4-git-send-email-tony@atomide.com>
 <546EF266.1010901@ti.com>
Message-ID: <20141121171804.GU7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [141121 00:09]:
> On Friday 21 November 2014 03:58 AM, Tony Lindgren wrote:
> > --- a/drivers/bus/Makefile
> > +++ b/drivers/bus/Makefile
> > @@ -5,7 +5,8 @@
> >  obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
> >  obj-$(CONFIG_IMX_WEIM)	+= imx-weim.o
> >  obj-$(CONFIG_MVEBU_MBUS) += mvebu-mbus.o
> > -obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
>
> I guess this is unrelated to $subject. Shouldn't this be dropped?

Yes thanks for catching that.

Regards,

Tony
