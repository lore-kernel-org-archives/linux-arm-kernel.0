From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 1 Sep 2014 09:35:32 +0530
Subject: [Patch v3] 7/7] cpufreq: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1409417172-6846-8-git-send-email-andrew@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
 <1409417172-6846-8-git-send-email-andrew@lunn.ch>
Message-ID: <CAOh2x=k5J3yzL1LAqzY4zQhA_iZT_cw47=S-E4k1+Q-UagE6pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 30, 2014 at 10:16 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
> ARCH_MVEBU is sufficient.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 7364a538e056..8c5cf4bdeab8 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -119,7 +119,7 @@ config ARM_INTEGRATOR
>           If in doubt, say Y.
>
>  config ARM_KIRKWOOD_CPUFREQ
> -       def_bool ARCH_KIRKWOOD || MACH_KIRKWOOD
> +       def_bool MACH_KIRKWOOD
>         help
>           This adds the CPUFreq driver for Marvell Kirkwood
>           SoCs.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
