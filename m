From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Jun 2013 13:45:18 +0000
Subject: [PATCH 2/2] arm: highbank: select HAVE_ARM_ARCH_TIMER
In-Reply-To: <1371462316-9201-3-git-send-email-mark.rutland@arm.com>
References: <1371462316-9201-1-git-send-email-mark.rutland@arm.com>
 <1371462316-9201-3-git-send-email-mark.rutland@arm.com>
Message-ID: <CAL_JsqJ=eAJc759f=mYcgfOUiVHBF4fx8y41uWOwAYh_qcFN4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 9:45 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> The ECX-2000 has architected timers, but support for them is not
> selected by default.
>
> Make MACH_HIGHBANK select HAVE_ARM_ARCH_TIMER, to ensure arhcited timer
> support is enabled by default.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <rob.herring@calxeda.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  arch/arm/mach-highbank/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
> index cd9fcb1..2bb896f 100644
> --- a/arch/arm/mach-highbank/Kconfig
> +++ b/arch/arm/mach-highbank/Kconfig
> @@ -11,6 +11,7 @@ config ARCH_HIGHBANK
>         select COMMON_CLK
>         select CPU_V7
>         select GENERIC_CLOCKEVENTS
> +       select HAVE_ARM_ARCH_TIMER
>         select HAVE_ARM_SCU
>         select HAVE_ARM_TWD if LOCAL_TIMERS
>         select HAVE_SMP
> --
> 1.8.1.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
