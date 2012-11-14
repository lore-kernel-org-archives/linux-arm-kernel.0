From: mgr@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 14:28:07 +0100
Subject: [PATCH 2/6] usb: chipidea: usbmisc: rename file, struct and
 functions to usbmisc_imx
In-Reply-To: <87pq3g71v9.fsf@ashishki-desk.ger.corp.intel.com>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352894137-2050-3-git-send-email-m.grzeschik@pengutronix.de>
 <87pq3g71v9.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20121114132807.GA12976@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 03:25:30PM +0200, Alexander Shishkin wrote:
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> 
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
> >  2 files changed, 163 insertions(+), 163 deletions(-)
> >  create mode 100644 drivers/usb/chipidea/usbmisc_imx.c
> >  delete mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c
> 
> Like Fabio suggested already, please use rename detection.
> Another thing, how do you get away with this without fixing the Makefile
> accordingly? Did you (at least) compile-test this patchset?

You are right, i have compile tested this patchset before adding this
patch. Sorry for that, i will test the whole series again on my
platform (mx53), before sending v2.

Regars,
Michael
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
