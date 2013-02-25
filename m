From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Feb 2013 15:50:01 +0100
Subject: [PATCH] ARM: mx27: Replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <20130225080727.GN1906@pengutronix.de>
References: <1354125330-18872-1-git-send-email-festevam@gmail.com>
 <CAOMZO5DZv3Xi-0hHpW=eU1GHZgEsNcsDzJh9Y+=-McbN7Vb=Lg@mail.gmail.com>
 <20121217204850.GT26326@pengutronix.de>
 <CAOMZO5AB49XQXHe18+hDVmHtMfC6WoHHQkKgmZMVFTgQL1h1Lw@mail.gmail.com>
 <20130225080727.GN1906@pengutronix.de>
Message-ID: <20130225145001.GB32025@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Feb 25, 2013 at 09:07:27AM +0100, Sascha Hauer wrote:
> On Sun, Feb 24, 2013 at 10:31:33PM -0300, Fabio Estevam wrote:
> > Hi Sascha,
> > 
> > On Mon, Dec 17, 2012 at 6:48 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > 
> > > Looks good from a first glance, but I want to give it some testing
> > > before I apply it.
> > 
> > Have you had a chance of testing this patch?
> 
> Damn, I missed this. However, Markus did test it. So it's fine for me.

Yes I tested this patch with imx27 pca100 and it works. So you can add

Tested-by: Markus Pargmann <mpa@pengutronix.de>

Markus

> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
