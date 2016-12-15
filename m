From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Dec 2016 20:33:07 +0100
Subject: [PATCH v6 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn0Ej90amOZUC2wGNBsTAZVmcqEaViV1-TeoaspiADBkkg@mail.gmail.com>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-3-git-send-email-cedric.madianga@gmail.com>
 <20161213092031.d2ax2pnpzzicriel@pengutronix.de>
 <CAOAejn0Ej90amOZUC2wGNBsTAZVmcqEaViV1-TeoaspiADBkkg@mail.gmail.com>
Message-ID: <20161215193307.436sggu4zy4zezoe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Cedric,

On Thu, Dec 15, 2016 at 04:26:25PM +0100, M'boumba Cedric Madianga wrote:
> >> +static struct platform_driver stm32f4_i2c_driver = {
> >> +     .driver = {
> >> +             .name = "stm32f4-i2c",
> >> +             .of_match_table = stm32f4_i2c_match,
> >
> > Is this needed?
> Without of_match_table, I could not match an I2C device instance from
> DT with this driver.
> So maybe, there is a misunderstanding.
> Could you please clarify your question ?

I thought (but I could be wrong) that if the driver is called
"stm32f4-i2c", it is used to match "st,stm32f4-i2c" even without
.of_match_table. If this doesn't work, please disregard my question.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
