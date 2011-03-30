From: davidb@codeaurora.org (David Brown)
Date: Wed, 30 Mar 2011 11:54:42 -0700
Subject: [PATCH] ARM: allow hotplug on msm
In-Reply-To: <1301078861-1991-1-git-send-email-johlstei@codeaurora.org> (Jeff
	Ohlstein's message of "Fri, 25 Mar 2011 11:47:41 -0700")
References: <1301078861-1991-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <8yabp0ssakt.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25 2011, Jeff Ohlstein wrote:

> Hotplug support was added in 9f1890a (msm: hotplug: support cpu hotplug
> on msm, 2010-12-02)
>
> Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
> ---
>  arch/arm/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 172e918..9485b6c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1358,7 +1358,6 @@ config NR_CPUS
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
>  	depends on SMP && HOTPLUG && EXPERIMENTAL
> -	depends on !ARCH_MSM
>  	help
>  	  Say Y here to experiment with turning CPUs off and on.  CPUs
>  	  can be controlled through /sys/devices/system/cpu.

This looks fine by me.  Russell, would you like Jeff to submit this to
your patch tracking system?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
