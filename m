From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 10:53:41 +0100
Subject: [PATCH 9/9] ARM: SPMP8000: Add Kconfig and Makefile entries to
	build the machine
In-Reply-To: <1318178172-7965-10-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-10-git-send-email-zoss@devai.org>
Message-ID: <20111013095341.GM21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 09, 2011 at 06:36:12PM +0200, Zoltan Devai wrote:
> +config ARCH_SPMP8000
> +	bool "Sunplus SPMP8000"
> +	select CPU_ARM926T
> +	select ARM_VIC
> +	select GENERIC_IRQ_CHIP
> +	select MULTI_IRQ_HANDLER
> +	select CLKSRC_MMIO
> +	select GENERIC_CLOCKEVENTS
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select USE_OF
> +	select CLKDEV_LOOKUP
> +	select HAVE_PWM
> +	select ARCH_HAS_CPUFREQ

Please arrange these select statements in alphabetical order - it helps
avoid the 'add to the end' conflict problem.
