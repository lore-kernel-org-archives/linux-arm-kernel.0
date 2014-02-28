From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Feb 2014 10:39:02 +0000
Subject: [PATCH] ARM: ux500: delete pointless DT config option
In-Reply-To: <1393582204-9156-1-git-send-email-linus.walleij@linaro.org>
References: <1393582204-9156-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140228103902.GA31720@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Supporting device tree on the Ux500 is not optional anymore,
> so delete the config option and compile this in at all times.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/Kconfig      | 5 -----
>  arch/arm/mach-ux500/cpu-db8500.c | 3 ---
>  2 files changed, 8 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
