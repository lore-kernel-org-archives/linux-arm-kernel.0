From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 20:26:06 +0800
Subject: [PATCH V3 2/6] PM / OPP: Rename opp init/free table routines
In-Reply-To: <6bdbc2c69b18528648d5a752da0d6176825bd870.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
 <6bdbc2c69b18528648d5a752da0d6176825bd870.1441354424.git.viresh.kumar@linaro.org>
Message-ID: <20150906122606.GT30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 01:47:23PM +0530, Viresh Kumar wrote:
> free-table routines are opposite of init-table ones, and must be named
> to make that clear. Opposite of 'init' is 'exit', but those doesn't suit
> really well.
> 
> Replace 'init' with 'add' and 'free' with 'remove'.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-imx/mach-imx6q.c       |  2 +-
...
>  drivers/cpufreq/imx6q-cpufreq.c      |  6 +++---

Acked-by: Shawn Guo <shawnguo@kernel.org>
