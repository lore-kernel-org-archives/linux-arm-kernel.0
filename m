From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 May 2018 11:43:29 +0530
Subject: [PATCH v2 2/9] PM / Domains: Drop __pm_genpd_add_device()
In-Reply-To: <20180529100421.31022-3-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-3-ulf.hansson@linaro.org>
Message-ID: <20180531061329.2sy7tl7gjhwqv276@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> There are still a few non-DT existing users of genpd, however neither of
> them uses __pm_genpd_add_device(), hence let's drop it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 10 ++++------
>  include/linux/pm_domain.h   | 14 +++-----------
>  2 files changed, 7 insertions(+), 17 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
