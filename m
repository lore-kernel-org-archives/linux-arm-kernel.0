From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Dec 2013 13:47:54 +0000
Subject: [PATCH] ARM: ux500: delete U8549 UART auxdata
In-Reply-To: <1386078176-3036-1-git-send-email-linus.walleij@linaro.org>
References: <1386078176-3036-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131203134754.GA28159@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Dec 2013, Linus Walleij wrote:

> The other Ux500's does not need this anymore, and the U8540
> certainly is no different.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/cpu-db8500.c | 4 ----
>  1 file changed, 4 deletions(-)

If you change the $SUBJECT you can have my:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
