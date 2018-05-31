From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 May 2018 12:34:26 +0530
Subject: [PATCH v2 7/9] PM / Domains: Split genpd_dev_pm_attach()
In-Reply-To: <20180529100421.31022-8-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-8-ulf.hansson@linaro.org>
Message-ID: <20180531070426.3olmew36foji32ge@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> To extend genpd to deal with allowing multiple PM domains per device, some
> of the code in genpd_dev_pm_attach() can be re-used. Let's prepare for this
> by moving some of the code into a sub-function.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 60 ++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 27 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
