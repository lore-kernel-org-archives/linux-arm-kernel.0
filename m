From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 May 2014 09:24:10 +0100
Subject: [PATCH 04/16] mfd: db8500-prcmu: Make mfd_cell array const
In-Reply-To: <1399978733-13662-4-git-send-email-k.kozlowski@samsung.com>
References: <1399978733-13662-1-git-send-email-k.kozlowski@samsung.com>
 <1399978733-13662-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140519082410.GI2339@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 May 2014, Krzysztof Kozlowski wrote:

> mfd_add_devices() expects array of struct mfd_cell to be const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/mfd/db8500-prcmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
