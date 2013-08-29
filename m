From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 29 Aug 2013 19:00:48 +0800
Subject: [PATCH RFC v2 05/16] ARM: imx: remove custom .init_time hook
In-Reply-To: <1377638890-371-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130829110045.GA18729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 11:27:59PM +0200, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove custom .init_time hooks.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> v1->v2:
> - added missing CLK_OF_DECLARE for imx51 and imx53 (Reported by Sascha Hauer)
>   mx53_clocks_init can be converted as it is used DT only, mx51_clocks_init
>   still is used by non-DT.
> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
