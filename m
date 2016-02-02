From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 2 Feb 2016 11:26:04 +0100
Subject: [PATCH 5/5] clk: sunxi: Remove clk_register_clkdev calls
In-Reply-To: <1454402834-6385-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160202112604.447baec98bf89a79542fd240@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  2 Feb 2016 09:47:14 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
> index 578bff0dd251..b38d71cec74c 100644
> --- a/drivers/clk/sunxi/clk-mod0.c
> +++ b/drivers/clk/sunxi/clk-mod0.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/clkdev.h>

Why?

>  #include <linux/clk-provider.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
