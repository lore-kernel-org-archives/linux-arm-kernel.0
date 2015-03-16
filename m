From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Mar 2015 15:32:45 +0100
Subject: [PATCH v6 5/6] ARM: dts: Alpine platform devicetree
In-Reply-To: <55017e28.Jzshpkksg8eI/q72%tsahee@annapurnalabs.com>
References: <55017e28.Jzshpkksg8eI/q72%tsahee@annapurnalabs.com>
Message-ID: <4546114.02tRG6ZkOu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 13:53:12 Tsahee Zidenberg wrote:
>  dtb-$(CONFIG_MACH_ASM9260) += \
>         alphascale-asm9260-devkit.dtb
> +
> +dtb-$(CONFIG_ARCH_ALPINE) += alpine_db.dtb
> +
>  # Keep at91 dtb files sorted alphabetically for each SoC
>  dtb-$(CONFIG_SOC_SAM_V4_V5) += \
>         at91rm9200ek.dtb \
> 

I've adapted the formatting slightly to keep alphabetical
ordering and the normal style that is used by the others here.

Please make sure you follow the local coding style for files
you touch in the future.

	Arnd
