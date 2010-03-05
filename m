From: albin.tonnerre@gmail.com (Albin Tonnerre)
Date: Fri, 5 Mar 2010 11:47:07 +0100
Subject: [PATCH] ARM: Add Versatile Express CA9x4 processor support
In-Reply-To: <git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
References: <git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
	<git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
Message-ID: <bbb699fe1003050247i4e12a596w6feea9a174c9b746@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> +config ARCH_VEXPRESS_CA9X4
> + ? ? ? bool "Versatile Express Cortex-A9x4 tile"
> + ? ? ? select CPU_V7
> + ? ? ? select ARM_GIC
