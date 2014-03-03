From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 03 Mar 2014 11:55:57 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzRdIG1mZDogbWMxM3h4eDogSG9ub3IgZGVzaWduZWQg?=
 =?UTF-8?B?U1BJIG1vZGU=?=
In-Reply-To: <20140303073524.GD4674@lee--X1>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
 <20140303073524.GD4674@lee--X1>
Message-ID: <1393833357.545249459@f190.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????,  3 ????? 2014, 15:35 +08:00 ?? Lee Jones <lee.jones@linaro.org>:
> > Instead of using hard coded SPI mode, use mode described in
> > devicetree or defined for the board.
> > Additionally, patch updates all users of this PMIC to use
> > correct SPI mode.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/mach-imx/mach-mx31lilly.c | 1 +
> >  arch/arm/mach-imx/mach-mx31lite.c  | 1 +
> >  drivers/mfd/mc13xxx-spi.c          | 2 --
> 
> There's no reason for these changes to be in the same patch.
> 
> Please split them up by subsystem and resubmit.

This should be in one patch, since it cause to break functionality of these
boards due missing SPI_CS_HIGH property in the spi_board_info.

---
