From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 15 Jun 2010 08:19:05 +0300
Subject: [PATCH 1/2] NUC900:  Add i2c0 driver support for NUC900
In-Reply-To: <4C15143C.1020603@gmail.com>
References: <4C15143C.1020603@gmail.com>
Message-ID: <20100615051905.GD3233@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wan,

On Mon, Jun 14, 2010 at 01:24:12AM +0800, Wan ZongShun wrote:
> This patch is to add i2c0 driver support for NUC900.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> 
> ---

[snip]

> +	pdata->get_clock(NULL, NULL, &apbclk_khz);

Why not use clk_get_rate() for this?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
