From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Nov 2013 08:56:51 +0000
Subject: [PATCH 2/2] clksrc: delete nomadik MTU non-DT boot path
In-Reply-To: <1384896499-9428-1-git-send-email-linus.walleij@linaro.org>
References: <1384896499-9428-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131120085651.GJ19953@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013, Linus Walleij wrote:

> Both platforms using the MTU (Nomadik and Ux500) have now been
> converted to use device tree exclusively, thus let us delete
> this platform data header and make this driver a fully
> self-contained DT-only driver.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
