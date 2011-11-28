From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 28 Nov 2011 12:21:51 -0800
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDAF8C5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang wrote at Friday, November 25, 2011 4:09 PM:
...
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
...
> +config PINMUX_PXA3xx
> +	bool "PXA pinmux driver"
> +	default y if ARCH_PXA || ARCH_MMP
> +	select PINMUX
> +

I thought the plan here was for e.g. ARCH_PXA to "select PINMUX_PXA3xxx",
since it's presumably mandatory?

-- 
nvpublic
