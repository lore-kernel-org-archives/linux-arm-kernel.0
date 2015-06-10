From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 10 Jun 2015 10:39:44 +0200
Subject: [RFT v2 06/48] pinctrl: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
In-Reply-To: <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <11293365.dyj0hfgNSb@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 4. Juni 2015, 12:13:16 schrieb Jiang Liu:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-rockchip.c            |    4 ++--


For Rockchip
Acked-by: Heiko Stuebner <heiko@sntech.de>
