From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Jan 2017 21:43:37 +0100
Subject: [PATCH 2/3] dts: teach newer i.MX machines to have the i.MX35
 type watchdog
In-Reply-To: <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
 <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
Message-ID: <20170116204337.j67oeknraas7ryib@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 04:35:26PM -0200, Fabio Estevam wrote:
> On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Only i.MX35 and newer feature a WMCR register that should be written to. Older
> > SoCs hang when this address is written.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Only a minor nit: Subject could: ARM: dts: imx: teach...

Ack. To reference the commit id of the first patch in the third I can
prepare a branch to pull. There I'd fix the Subject. Shawn, is this OK?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
