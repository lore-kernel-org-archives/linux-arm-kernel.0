From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 22 Dec 2010 12:41:48 +0100
Subject: [PATCH] ARM: mxs: Change duart device to use amba-pl011
In-Reply-To: <20101222021049.GI16497@freescale.com>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
	<1292937130-32155-1-git-send-email-shawn.guo@freescale.com>
	<20101221203121.GB31617@pengutronix.de>
	<20101222021049.GI16497@freescale.com>
Message-ID: <20101222114148.GB4368@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Dec 22, 2010 at 10:10:50AM +0800, Shawn Guo wrote:

> [...]
> > >  static struct clk_lookup lookups[] = {
> > > -	_REGISTER_CLOCK("mxs-duart.0", NULL, uart_clk)
> > > +	_REGISTER_CLOCK("uart", NULL, uart_clk)
> > 
> > Maybe "duart"?
> > 
> I was thinking about the naming "uart" vs "duart" here, and decided to
> pick the "uart", because this is the name of clock "uart_clk", which
> is the clock for uart domain, not only duart.

Makes sense.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101222/aab050cb/attachment.sig>
