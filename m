From: david-b@pacbell.net (David Brownell)
Date: Sat, 28 Nov 2009 18:51:19 -0800
Subject: gpio: pca953x: add support for MAX7312
In-Reply-To: <f17812d70911281821j602dc2bcvbda387e3e989e466@mail.gmail.com>
References: <f17812d70911281821j602dc2bcvbda387e3e989e466@mail.gmail.com>
Message-ID: <200911281851.19960.david-b@pacbell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 November 2009, Eric Miao wrote:
> >From e7a5c19103616e7e9252d189d455d136b4c25c51 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Sun, 29 Nov 2009 09:41:54 +0800
> Subject: [PATCH] gpio: pca953x: add support for MAX7312
> 
> Signed-off-by: Jun Nie <njun@marvell.com>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

> ---
>  drivers/gpio/pca953x.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
> index 6a2fb3f..cfff189 100644
> --- a/drivers/gpio/pca953x.c
> +++ b/drivers/gpio/pca953x.c
> @@ -39,6 +39,7 @@ static const struct i2c_device_id pca953x_id[] = {
>  	{ "pca9557", 8, },
> 
>  	{ "max7310", 8, },
> +	{ "max7312", 16 },
>  	{ "max7315", 8, },
>  	{ "pca6107", 8, },
>  	{ "tca6408", 8, },
> -- 
> 1.6.3.3
> 
> 
