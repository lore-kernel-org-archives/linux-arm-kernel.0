From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Nov 2013 08:54:23 +0000
Subject: [PATCH] ARM: ux500: delete Nomadik pinctrl AUXDATA
In-Reply-To: <1384897744-30801-1-git-send-email-linus.walleij@linaro.org>
References: <1384897744-30801-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131120085423.GG19953@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013, Linus Walleij wrote:

> This deletes the AUXDATA hammering down the Nomadik pin
> controller name to "pinctrl-db8500". We have removed all
> dependencies on this name.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/cpu-db8500.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
