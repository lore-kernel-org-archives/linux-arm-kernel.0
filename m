From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Sep 2018 10:48:17 +0100
Subject: [PATCH v12 0/6] Driver for at91 usart in spi mode
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Message-ID: <20180910094817.GJ28860@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Sep 2018, Radu Pirea wrote:
> Well, this is the 12th version of this patch series.
> In this version I fixed a warning from kbuild-robot and I have no idea
> how I forgot to add static in declaration of that functions. Also I
> fixed the example for the SPI driver in bindings.

Okay great.  So which patches still require Acks?

[...]

> Radu Pirea (6):
>   MAINTAINERS: add at91 usart mfd driver
>   dt-bindings: add binding for atmel-usart in SPI mode
>   mfd: at91-usart: added mfd driver for usart
>   MAINTAINERS: add at91 usart spi driver
>   spi: at91-usart: add driver for at91-usart as spi
>   tty/serial: atmel: change the driver to work under at91-usart mfd

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
