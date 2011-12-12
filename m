From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 14:10:01 +0000
Subject: [PATCH v3 2/2] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <1323690426-6267-3-git-send-email-dave.martin@linaro.org>
References: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
 <1323690426-6267-3-git-send-email-dave.martin@linaro.org>
Message-ID: <20111212141001.GZ14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 11:47:06AM +0000, Dave Martin wrote:
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 4234937..4aa7f7e 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -611,6 +611,7 @@ config SOC_IMX6Q
>  	select ARM_GIC
>  	select CPU_V7
>  	select HAVE_ARM_SCU
> +	select HAVE_SMP
>  	select HAVE_IMX_GPC
>  	select HAVE_IMX_MMDC
>  	select HAVE_IMX_SRC

NAK.  I'll let you work out why.  It has something to do with ABCDEFGH...
