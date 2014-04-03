From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 3 Apr 2014 20:10:58 +0530
Subject: [PATCH] ARM64: Remove duplicated Kconfig entry for
 "kernel/power/Kconfig"
In-Reply-To: <1396523809-6945-1-git-send-email-hanjun.guo@linaro.org>
References: <1396523809-6945-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <CAKohpokpYLLTQTrqfE1o61hLyzW6Z3+HtMM3wjqE732cKskD2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2014 16:46, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> There is a duplicated Kconfig entry for "kernel/power/Kconfig"
> in menu "Power management options" and "CPU Power Management",
> remove the one from menu "CPU Power Management" suggested by
> Viresh.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/Kconfig |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e6e4d37..e759af5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -323,8 +323,6 @@ menu "CPU Power Management"
>
>  source "drivers/cpuidle/Kconfig"
>
> -source "kernel/power/Kconfig"
> -
>  source "drivers/cpufreq/Kconfig"
>
>  endmenu

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
