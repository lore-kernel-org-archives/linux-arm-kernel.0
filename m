From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 13 Nov 2010 15:38:27 +0300
Subject: [PATCH v2 20/20] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <1289584840-18097-21-git-send-email-catalin.marinas@arm.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-21-git-send-email-catalin.marinas@arm.com>
Message-ID: <4CDE86C3.9080407@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-11-2010 21:00, Catalin Marinas wrote:

> This patch adds the ARM_LPAE and ARCH_PHYS_ADDR_T_64BIT Kconfig entries
> allowing LPAE support to be compiled into the kernel.

> Signed-off-by: Catalin Marinas<catalin.marinas@arm.com>
[...]

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 8493ed0..3ca2d15 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -615,6 +615,19 @@ config IO_36
>
>   comment "Processor Features"
>
> +config ARM_LPAE
> +	bool "Support for the Large Physical Address Extension"
> +	depends on MMU&&  CPU_V7
> +	help
> +	  Say Y if you have an ARMv7 processor supporting the LPAE page table
> +	  format and you would like access memory beyond the 4GB limit.

    Maybe "like to access"?

WBR, Sergei
