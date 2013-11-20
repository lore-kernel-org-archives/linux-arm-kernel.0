From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Nov 2013 08:55:39 +0000
Subject: [PATCH 1/2] ARM: ux500: decomission the non-DT MTU init sequence
In-Reply-To: <1384896471-9384-1-git-send-email-linus.walleij@linaro.org>
References: <1384896471-9384-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131120085539.GI19953@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013, Linus Walleij wrote:

> The MTU is now only initialized using the native clocksource
> device tree matching.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/timer.c | 28 ++--------------------------
>  1 file changed, 2 insertions(+), 26 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
