From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Sep 2013 09:16:22 +0100
Subject: [PATCH] ARM: ux500: delete devices-common remnants
In-Reply-To: <1380187608-26492-1-git-send-email-linus.walleij@linaro.org>
References: <1380187608-26492-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130927081622.GB9048@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Sep 2013, Linus Walleij wrote:

> commit f1ff5b2549990b5de080b52e3313cbb30c218853
> "ARM: ux500: Stop enabling GPIOs when not booting with Device Tree"
> deleted devices-common.c, but did not delete the build
> rule from Makefile (most likely due to compiling in
> a dirty tree where the object file still existed so
> linking would complete anyway).
> 
> Delete the makerule, the header file associated
> with this file and the remaining reference to the header.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/Makefile         |  3 +--
>  arch/arm/mach-ux500/devices-common.h | 15 ---------------
>  arch/arm/mach-ux500/devices-db8500.h |  1 -
>  3 files changed, 1 insertion(+), 18 deletions(-)
>  delete mode 100644 arch/arm/mach-ux500/devices-common.h
> 
> diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
