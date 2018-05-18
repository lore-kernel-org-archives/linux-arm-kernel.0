From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2018 14:27:11 +0100
Subject: [PATCH REPOST] mfd: syscon: atmel-smc: include string.h
In-Reply-To: <20180504103446.20104-1-bigeasy@linutronix.de>
References: <20180504103446.20104-1-bigeasy@linutronix.de>
Message-ID: <20180518132711.GM5130@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 May 2018, Sebastian Andrzej Siewior wrote:

> The string.h header file is needed for the memset() definition. The RT
> build fails because it is not pulled in via other header files.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/mfd/atmel-smc.c |    1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
