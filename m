From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 May 2018 11:48:21 +0530
Subject: [PATCH v2 5/9] PM / Domains: dt: Allow power-domain property to
 be a list of specifiers
In-Reply-To: <20180529100421.31022-6-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-6-ulf.hansson@linaro.org>
Message-ID: <20180531061821.wcasbwr3s7lphr4a@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> To be able to describe topologies where devices are partitioned across
> multiple power domains, let's extend the power-domain property to allow
> being a list of PM domain specifiers.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
