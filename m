From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 20:27:16 +0800
Subject: [PATCH V3 3/6] PM / OPP: Prefix exported opp routines with
 dev_pm_opp_
In-Reply-To: <5304383f1a99f2fd3a90c0a4cc1df4930b26a843.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
 <5304383f1a99f2fd3a90c0a4cc1df4930b26a843.1441354424.git.viresh.kumar@linaro.org>
Message-ID: <20150906122716.GU30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 01:47:24PM +0530, Viresh Kumar wrote:
> That's the naming convention followed in most of opp core, but few
> routines didn't follow this, fix them.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-imx/mach-imx6q.c       |  2 +-
...
>  drivers/cpufreq/imx6q-cpufreq.c      |  6 +++---

Acked-by: Shawn Guo <shawnguo@kernel.org>
