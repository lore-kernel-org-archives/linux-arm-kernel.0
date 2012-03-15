From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Mar 2012 17:11:45 +0100
Subject: [PATCH 10/10] ARM: ux500: Enable PL022 SSP Controller in Device
 Tree
In-Reply-To: <1331730306-11461-11-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
 <1331730306-11461-11-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaYDjyYDo9HCkHSyQrQuQP3Hp7TUZKTCXOseeoLxXh6Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 2:05 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This SSP Controller supports a number of serial communication methods.
>
> Namely:
>
> /**
> ?* enum ssp_interface - interfaces allowed for this SSP Controller
> ?* @SSP_INTERFACE_MOTOROLA_SPI: Motorola Interface
> ?* @SSP_INTERFACE_TI_SYNC_SERIAL: Texas Instrument Synchronous Serial
> ?* interface
> ?* @SSP_INTERFACE_NATIONAL_MICROWIRE: National Semiconductor Microwire
> ?* interface
> ?* @SSP_INTERFACE_UNIDIRECTIONAL: Unidirectional interface (STn8810
> ?* &STn8815 only)
> ?*/
>
> ... and as such cannot be registered using of_register_spi_devices.
> Instead it can be registered simply as a primecell device.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Why is the commit message all about what the patch cannot do rather
than on what it does, anyway, begin with stating what you do and
its:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
