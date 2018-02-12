From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 12 Feb 2018 13:22:55 +0200
Subject: [PATCH] MAINTAINERS: add Freescale pin controllers
In-Reply-To: <1518432502.2744.5.camel@pengutronix.de>
References: <20180210153204.12728-1-stefan@agner.ch>
 <1518432502.2744.5.camel@pengutronix.de>
Message-ID: <20180212112255.u333xb676kfmi63f@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Mon, Feb 12, 2018 at 11:48:22AM +0100, Lucas Stach wrote:
> Am Samstag, den 10.02.2018, 16:32 +0100 schrieb Stefan Agner:
> > Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
> > and Sascha as reviewer.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> > ?MAINTAINERS | 11 +++++++++++
> > ?1 file changed, 11 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 82ad0eabce4f..fb672dfc519d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10768,6 +10768,17 @@ L:	linux-gpio at vger.kernel.org
> > ?S:	Supported
> > ?F:	drivers/pinctrl/pinctrl-at91-pio4.*
> > ?
> > +PIN CONTROLLER - FREESCALE
> > +M:	Dong Aisheng <aisheng.dong@nxp.com>
> > +M:	Fabio Estevam <festevam@gmail.com>
> > +M:	Shawn Guo <shawnguo@kernel.org>
> > +M:	Stefan Agner <stefan@agner.ch>
> > +R:	Sascha Hauer <kernel@pengutronix.de>
> 
> I'm fine with the patch, but it might make sense to clarify this a bit:
> the kernel@ address is really the whole Pengutronix kernel team, not
> just Sascha. Using this address is totally fine if you expect comments
> on patches, as it gives them a quite wide exposure inside of PTX.

Of the 5 mentions of kernel at pengutronix.de in MAINTAINERS as of v4.16-rc1, 
three name Sascha, and two name Uwe. Would you like to also clarify those?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
