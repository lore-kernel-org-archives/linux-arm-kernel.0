From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 8 Jun 2013 10:45:43 +0200
Subject: [PATCH v2] ARM: imx: Remove mxc specific ulpi access ops
In-Reply-To: <CAOMZO5AsLgWUX==n1pqn8jFu=krJx8L6q7GRNyP17aBQJsunuw@mail.gmail.com>
References: <1370522517-2873-1-git-send-email-mpa@pengutronix.de>
 <CAOMZO5AsLgWUX==n1pqn8jFu=krJx8L6q7GRNyP17aBQJsunuw@mail.gmail.com>
Message-ID: <20130608084543.GA7755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Jun 06, 2013 at 10:20:20AM -0300, Fabio Estevam wrote:
> Hi Markus,
> 
> On Thu, Jun 6, 2013 at 9:41 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> > There are ulpi access ops implemented in drivers/usb/phy/phy-ulpi.c.
> > mxc access ops implement the same access operations within mach-imx. This
> > patch removes the mxc ulpi file and uses phy-ulpi instead for
> > imx_otg_ulpi_create.
> >
> > phy-ulpi successfully tested with i.MX27 Phytec phyCARD-S (pca100).
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Unrelated to this patch, but just out of curiosity: have you also try
> to use the chipidea driver with mx27?

Yes, I tried the chipidea driver with mx27 and created some patches for
it. I didn't send the patches yet.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
