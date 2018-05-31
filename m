From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 May 2018 11:46:02 +0530
Subject: [PATCH v2 4/9] PM / Domains: Drop unused parameter in
 genpd_allocate_dev_data()
In-Reply-To: <20180529100421.31022-5-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-5-ulf.hansson@linaro.org>
Message-ID: <20180531061602.jaipvmlsslsb3j55@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> The in-parameter struct generic_pm_domain *genpd to
> genpd_allocate_dev_data() is unused, so let's drop it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
