From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 25 Feb 2016 07:40:07 +0530
Subject: [PATCH 26/50] pinctrl: spear: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-27-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-27-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160225021007.GA31255@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-02-16, 18:45, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration and remove
> need of .remove callback.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: spear-devel at list.st.com
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/pinctrl/spear/pinctrl-spear.c     | 11 +----------
>  drivers/pinctrl/spear/pinctrl-spear.h     |  1 -
>  drivers/pinctrl/spear/pinctrl-spear1310.c |  6 ------
>  drivers/pinctrl/spear/pinctrl-spear1340.c |  6 ------
>  drivers/pinctrl/spear/pinctrl-spear300.c  |  6 ------
>  drivers/pinctrl/spear/pinctrl-spear310.c  |  6 ------
>  drivers/pinctrl/spear/pinctrl-spear320.c  |  6 ------
>  7 files changed, 1 insertion(+), 41 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
