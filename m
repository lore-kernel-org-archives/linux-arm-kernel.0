From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 30 Jul 2013 10:41:09 +0200
Subject: [RFC 1/8] gpio: mxc: Use devm_ functions
In-Reply-To: <CAOMZO5Afr5zZLonmHm1PO4L6ed5SJ2K+vywX3Uu1etBTcrryYg@mail.gmail.com>
References: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
 <1374938808-27316-2-git-send-email-mpa@pengutronix.de>
 <20130730031436.GE19715@S2101-09.ap.freescale.net>
 <CAOMZO5Afr5zZLonmHm1PO4L6ed5SJ2K+vywX3Uu1etBTcrryYg@mail.gmail.com>
Message-ID: <20130730084109.GJ16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:45:33AM -0300, Fabio Estevam wrote:
> On Tue, Jul 30, 2013 at 12:14 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > It can be even cleaner by using devm_ioremap_resource().
> 
> I have already sent a patch that converts to devm_ioremap_resource()
> and it is already in Linus Walleij's tree.
> 
Thanks, I will remove this patch and use yours.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
