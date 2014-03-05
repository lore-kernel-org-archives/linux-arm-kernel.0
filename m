From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 5 Mar 2014 09:50:53 +0800
Subject: [PATCH 2/2] mfd: pm8921: Use IRQCHIP_SKIP_SET_WAKE
In-Reply-To: <1393958932-3585-3-git-send-email-sboyd@codeaurora.org>
References: <1393958932-3585-1-git-send-email-sboyd@codeaurora.org>
 <1393958932-3585-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140305015053.GJ10579@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We don't need to implement a dummy irq_set_wake op if we just set
> IRQCHIP_SKIP_SET_WAKE.
> 
> Suggested-by: Josh Cartwright <joshc@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/pm8921-core.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
