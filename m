From: albin.tonnerre@gmail.com (Albin Tonnerre)
Date: Fri, 5 Mar 2010 11:27:13 +0100
Subject: [PATCH] ARM: Add Versatile Express support
In-Reply-To: <git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
References: <git-1267729916-9e7380877e37e33ffe507b0299aa4c6e9cac599e@rmk-PC>
	<git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
Message-ID: <bbb699fe1003050227k7583de6w8232ddac44d04d8d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> +config ARCH_VEXPRESS
> + ? ? ? bool "ARM Ltd. Versatile Express family"
> + ? ? ? select ARCH_WANT_OPTIONAL_GPIOLIB
> + ? ? ? select ARM_AMBA
> + ? ? ? select ARM_TIMER_SP804

You need platform.h, as it's used in arch/arm/plat-versatile/timer-sp.c
Unless I'm mistaken, it's missing from this patchset.

Otherwise, Tested-By: Albin Tonnerre <albin.tonnerre@gmail.com>
