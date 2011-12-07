From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 19:00:48 +0800
Subject: [MXS MMC 1/5] Fix grammatical error in comment
In-Reply-To: <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323177907.git.LW@KARO-electronics.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323177907.git.LW@KARO-electronics.de>
Message-ID: <20111207110047.GI5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 02:41:26PM +0100, Lothar Wa?mann wrote:
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/mach-mxs/clock-mx28.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index da6e4aa..fc86b04 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -554,7 +554,7 @@ static struct clk rtc_clk = {
>  	.parent = &ref_xtal_clk,
>  };
>  
> -/* usb_clk gate is controlled in DIGCTRL other than CLKCTRL */
> +/* usb_clk gate is controlled in DIGCTRL rather than CLKCTRL */
>  static struct clk usb0_clk = {
>  	.enable_reg = DIGCTRL_BASE_ADDR,
>  	.enable_shift = 2,
> -- 

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
