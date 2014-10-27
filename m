From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 27 Oct 2014 16:18:09 +0300
Subject: [PATCH 1/2] ARM: add mach-asm9260
In-Reply-To: <1414401792-7445-2-git-send-email-linux@rempel-privat.de>
References: <1414401792-7445-1-git-send-email-linux@rempel-privat.de>
 <1414401792-7445-2-git-send-email-linux@rempel-privat.de>
Message-ID: <544E4611.8070802@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/27/2014 12:23 PM, Oleksij Rempel wrote:

> it is low cost (?) SoC targeted for market in China and India which
> trying to compete with AT91SAM9G25.

> Here is some info:
> http://www.alphascale.com/index.asp?ics/615.html

> One of products:
> http://www.aliexpress.com/store/product/2014-hot-sales-FREE-SHIPPING-new-Purple-core-ARM9-development-board-ASM9260T-SDRAM-power-line/433637_1931495721.html

> In some cases this SoC looks similar to iMX23/iMX28. But currently it makes no
> sense to merge mach code of this devices. Especially because most differences
> are already collected mach-mxs folder.

> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>

[...]

> diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
> new file mode 100644
> index 0000000..33b9b28
> --- /dev/null
> +++ b/arch/arm/mach-asm9260/Kconfig
> @@ -0,0 +1,6 @@
> +config MACH_ASM9260
> +	bool "Alphascale ASM9260"
> +	depends on ARCH_MULTI_V5
> +	select CPU_ARM926T
> +	help
> +	  Support for Alpascale ASM9260 based platform.

    s/Alpascale/Alphascale/?

WBR, Sergei
