From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Jun 2012 12:16:42 +0200
Subject: [PATCH 0/2] A couple of imx6q clock patches
In-Reply-To: <1338880603-24333-1-git-send-email-shawn.guo@linaro.org>
References: <1338880603-24333-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120606101642.GX30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn, Olof,

On Tue, Jun 05, 2012 at 03:16:41PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> These two patches are based on v3.5-rc1 + your imx-clk-common-fixes.
> I can wait for your imx-clk-common-fixes hit -rc and then send these
> two.  But I think the better approach would be you rebase
> imx-clk-common-fixes on -rc1 and then pick up these two into your
> fix series.

Olof, what do you prefer? Is there still time to update the
imx-clk-common-fixes you already pulled?

Sascha


> 
> The first one is a small clean up which can be amended into b0286f2
> (ARM: imx6q: prepare and enable init on clks directly instead of
> clk_get first), and the second one fixes a suspend regression.
> 
> Regards,
> Shawn
> 
> Shawn Guo (2):
>   ARM: imx6q: remove unneeded clkdev lookups
>   ARM: imx6q: fix suspend regression caused by common clk migration
> 
>  arch/arm/mach-imx/clk-imx6q.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> -- 
> 1.7.5.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
