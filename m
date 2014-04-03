From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 3 Apr 2014 09:53:56 +0530
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <20140402144020.GA20438@zod>
References: <CA+5PVA6awqaSHQboqdv9nynV9Xjp46VeqijDWxZX1v5wDK0NWQ@mail.gmail.com>
 <CAKohpok3gKyOWD0=pSv0yQLNqJcNPNZagRGFXNFHW+3J7E=mOg@mail.gmail.com>
 <20140402144020.GA20438@zod>
Message-ID: <CAOh2x=nHX0_2v0WtBAh6xLqmkk1SVQSpNZX54jirByDCwtoSXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 8:10 PM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> Commit 74397174989e5f70 attempted to clean up the power management options
> for arm64, but when things were merged it didn't fully take effect.  Fix
> it again.
>
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> ---
>  arch/arm64/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 07aa3556952c..8033b9b8a2df 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -321,12 +321,6 @@ menu "CPU Power Management"
>
>  source "drivers/cpuidle/Kconfig"
>
> -source "drivers/cpufreq/Kconfig"
> -
> -endmenu
> -
> -menu "Power management options"
> -
>  source "kernel/power/Kconfig"
>
>  source "drivers/cpufreq/Kconfig"

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
