From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 20:34:54 +0200
Subject: [PATCH V3 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1409757194-28155-5-git-send-email-bhupesh.sharma@freescale.com>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409757194-28155-5-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <3908508.RbGYaA1nXT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 20:43:12 Bhupesh Sharma wrote:
> diff --git a/arch/arm64/boot/dts/fsl-ls2085a-simu.dts b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> new file mode 100644
> index 0000000..3c0f953
> --- /dev/null
> +++ b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> @@ -0,0 +1,26 @@
> +/*
> + * Device Tree file for Freescale LS2085a software Simulator model
> + *
> + * Copyright (C) 2014, Freescale Semiconductor
> + *
> + * Bhupesh Sharma <bhupesh.sharma@freescale.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> 

One more thing, same comment as for the respective Exynos7 patch:
can this please be a permissive license, like GPLv2+MIT dual
license?

	Arnd
