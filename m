From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jan 2017 21:50:05 +0100
Subject: [PATCH] ARM: ux500: cut some platform data
In-Reply-To: <20170113131648.24889-1-linus.walleij@linaro.org>
References: <20170113131648.24889-1-linus.walleij@linaro.org>
Message-ID: <3053082.ssGyjMO9fc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 13, 2017 2:16:48 PM CET Linus Walleij wrote:
> This platform data is revoked: the drivers are getting the DMA
> configuration from the device tree, it has been done like that
> since the DMA support was merged and this data has not been used
> since. The remaining auxdata is also unused.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500-audio.c | 77 -----------------------------
>  arch/arm/mach-ux500/board-mop500.h       | 17 -------
>  arch/arm/mach-ux500/cpu-db8500.c         | 16 ------
>  arch/arm/mach-ux500/ste-dma40-db8500.h   | 85 --------------------------------
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
