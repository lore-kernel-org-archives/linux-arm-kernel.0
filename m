From: liu.h.jason@gmail.com (Jason Liu)
Date: Wed, 2 Mar 2011 15:14:30 +0800
Subject: [PATCH 1/5] ARM: mx35_3ds: Add I2C support
In-Reply-To: <20110301201703.GX22310@pengutronix.de>
References: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
	<20110301201703.GX22310@pengutronix.de>
Message-ID: <AANLkTi=c_vWNqBbqPzRpCzWD-s5PFvLmD8ROr=Jss1hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Uwe,

2011/3/2 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Tue, Mar 01, 2011 at 04:59:44PM -0300, Fabio Estevam wrote:
>> + ? ? imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
> I'd slightly prefer using
>
> ? ? ? ?imx35_add_imx_i2c(0, ...)
>
> because I intend to remove the imx35_add_imx_i2c0-like macros soon. ?But

Could you please explain why you intend to remove
imx35_add_imx_i2c0-like macros?
What you would like to do instead? Thanks,

> if nothing else pops up there is no need to respin the series because of
> that.
>
> Other than that all 5 patches look good;
> ? ? ? ?Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
