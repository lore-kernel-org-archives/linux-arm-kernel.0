From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:43:07 +0100
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <1313526898-19920-3-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
Message-ID: <20110817074307.GB1006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
> +config ARCH_HIGHBANK
> +	bool "Calxeda Highbank-based"
> +	select CPU_V7
> +	select AUTO_ZRELADDR
> +	select ARM_PATCH_PHYS_VIRT
> +	select ARM_GIC
> +	select HAVE_ARM_SCU
> +	select ARM_AMBA
> +	select ARM_TIMER_SP804
> +	select PL330
> +	select CLKDEV_LOOKUP
> +	select GENERIC_CLOCKEVENTS
> +	select USE_OF
> +	select ARCH_WANT_OPTIONAL_GPIOLIB

Please arrange these select statements in alphabetical order.

> diff --git a/arch/arm/mach-highbank/include/mach/memory.h b/arch/arm/mach-highbank/include/mach/memory.h
> new file mode 100644
> index 0000000..8b13789
> --- /dev/null
> +++ b/arch/arm/mach-highbank/include/mach/memory.h
> @@ -0,0 +1 @@
> +

It's good practice to put something in a file other than a blank line.
