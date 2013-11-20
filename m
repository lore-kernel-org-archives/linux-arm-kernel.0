From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Nov 2013 08:53:52 +0000
Subject: [PATCH] ARM: ux500: get rid of unused header
In-Reply-To: <1384898168-12809-1-git-send-email-linus.walleij@linaro.org>
References: <1384898168-12809-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131120085351.GF19953@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013, Linus Walleij wrote:

> This removes the unused inclusion of
> <linux/platform_data/pinctrl-nomadik.h> which is
> the last user in the entire kernel of this platform
> data header.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500-audio.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
