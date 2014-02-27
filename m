From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Feb 2014 08:34:08 +0000
Subject: [PATCH v4 2/8] mfd: pm8921: Update for genirq changes
In-Reply-To: <1393441166-32692-3-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
 <1393441166-32692-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227083408.GV9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Since this code has been marked broken for some time a few genirq
> tree wide changes weren't made. set_irq_wake() was renamed to
> irq_set_irq_wake() in commit a0cd9ca2b (genirq: Namespace
> cleanup, 2011-02-10) and commit 10a8c383 (irq: introduce entry
> and exit functions for chained handlers) introduced the chained
> irq functions but this driver wasn't updated to use them. Fix
> these problems and remove the BROKEN marking on this driver.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/Kconfig       | 1 -
>  drivers/mfd/pm8921-core.c | 7 +++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
