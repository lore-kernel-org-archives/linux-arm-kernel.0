From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 5 Mar 2014 09:50:28 +0800
Subject: [PATCH 1/2] mfd: pm8921: Drop irq_set_lockdep_class() code
In-Reply-To: <1393958932-3585-2-git-send-email-sboyd@codeaurora.org>
References: <1393958932-3585-1-git-send-email-sboyd@codeaurora.org>
 <1393958932-3585-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140305015028.GI10579@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This isn't necessary as we aren't setting the summary interrupt
> to wake up the system in the irq_wake() callback.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/pm8921-core.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
