From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 13 May 2018 16:14:38 +0300
Subject: [PATCH v3 3/6] MAINTAINERS: add at91 usart spi driver
In-Reply-To: <20180511103822.31698-4-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-4-radu.pirea@microchip.com>
Message-ID: <CAHp75VdXrQ_NKBmP0L9o8_2MSqehNuriQ0gBJ3dDWQdegALSaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> Added entry for at91 usart mfd driver.
>

You are adding a record for not existing file?

> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca06c6f58299..9243b9007966 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9199,6 +9199,13 @@ S:       Supported
>  F:     drivers/mfd/at91-usart.c
>  F:     include/dt-bindings/mfd/at91-usart.h
>
> +MICROCHIP AT91 USART SPI DRIVER
> +M:     Radu Pirea <radu.pirea@microchip.com>
> +L:     linux-spi at vger.kernel.org
> +S:     Supported
> +F:     drivers/spi/spi-at91-usart.c
> +F:     Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> +
>  MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
>  M:     Woojung Huh <Woojung.Huh@microchip.com>
>  M:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
