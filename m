From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Dec 2010 12:46:35 +0100
Subject: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
	clock
In-Reply-To: <20101210131837.GA3783@infomag.iguana.be>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
	<20101210131837.GA3783@infomag.iguana.be>
Message-ID: <20101213114635.GG6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 02:18:37PM +0100, Wim Van Sebroeck wrote:
> Hi All,
> 
> > Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Since this looks more arch specific, can this go via the arm kernel tree?

Yes, please. I already scheduled this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
