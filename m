From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jul 2011 11:28:24 +0200
Subject: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
	configuration
In-Reply-To: <1310310203-12288-1-git-send-email-sundaram@ti.com>
References: <y>
	<1310310203-12288-1-git-send-email-sundaram@ti.com>
Message-ID: <CAKnu2MqzSm8BVK4z9E-ud8e_jUohDfSfYO9aW-oN3RFw4p7GrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/10 Sundaram Raju <sundaram@ti.com>:

> Added new dma_ctrl_cmd TI_DMA_STRIDE_CONFIG to pass the TI DMA
> controller specific configurations on how a buffer must be walked
> through and how data is picked for transfer based on a specified
> pattern over the channel.
>
> The configuration passed is specific to the TI DMA controller used.
>
> Signed-off-by: Sundaram Raju <sundaram@ti.com>

This is exactly how I think we should do this.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
