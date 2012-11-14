From: mgr@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 16:32:03 +0100
Subject: [PATCH 2/6] usb: chipidea: usbmisc: rename file, struct and
 functions to usbmisc_imx
In-Reply-To: <CAOMZO5Ajdp3DT1b+Mx6ufjhuCoOmZ6CEwk+TgWEj-mjd1Hub1Q@mail.gmail.com>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352894137-2050-3-git-send-email-m.grzeschik@pengutronix.de>
 <CAOMZO5Ajdp3DT1b+Mx6ufjhuCoOmZ6CEwk+TgWEj-mjd1Hub1Q@mail.gmail.com>
Message-ID: <20121114153203.GB13387@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 09:57:50AM -0200, Fabio Estevam wrote:
> Hi Michael,
> 
> On Wed, Nov 14, 2012 at 9:55 AM, Michael Grzeschik
> <m.grzeschik@pengutronix.de> wrote:
> > This driver will be used for every Freescale SoC which has this misc
> > memory layout to control the basic usb handling. So better name this
> > driver, function and struct names in a more generic way.
> >
> > Reported-by: Fabio Estevam <festevam@gmail.com>
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/usb/chipidea/usbmisc_imx.c   |  163 ++++++++++++++++++++++++++++++++++
> >  drivers/usb/chipidea/usbmisc_imx6q.c |  163 ----------------------------------
> 
> Please use git mv / git format -M so that git can detect the file rename.

I have created this patch with git mv. Until now, i did not know
that git send-email needs -M to stick with the git format.

Will change that in V2.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
