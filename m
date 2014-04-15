From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 15 Apr 2014 07:01:39 +0200
Subject: [PATCH] clk: sirf: fix a bundle of checkpatch issues
In-Reply-To: <1397529603-16937-1-git-send-email-21cnbao@gmail.com>
References: <1397529603-16937-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20140415050139.GF5969@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Apr 15, 2014 at 10:40:03AM +0800, Barry Song wrote:
> From: Bin Shi <Bin.Shi@csr.com>
> diff --git a/drivers/clk/sirf/clk-atlas6.c b/drivers/clk/sirf/clk-atlas6.c
> index d63b76c..b068feb 100644
> --- a/drivers/clk/sirf/clk-atlas6.c
> +++ b/drivers/clk/sirf/clk-atlas6.c
> @@ -60,10 +60,10 @@ static struct clk_dmn clk_nand = {
>  
>  enum atlas6_clk_index {
>  	/* 0    1     2      3      4      5      6       7         8      9 */
> -	rtc,    osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
> -	mf,     io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
> -	spi1,   pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
> -	usp2,   vip,   gfx,   gfx2d,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
> +	rtc,  osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
> +	mf,   io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
> +	spi1, pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
> +	usp2, vip,   gfx,   gfx2d, lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
>  	usb0,  usb1,   cphif, maxclk,
Here only the indention is changed, right? I wonder why the last line
was not fixed to be aligned with the others.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
