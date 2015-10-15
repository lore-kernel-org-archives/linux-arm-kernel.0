From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 16:19:38 +0200
Subject: [PATCH v3 12/12] dts/Makefile: Add build support for LS2080a QDS
 & RDB board DTS
In-Reply-To: <1444891672-32117-13-git-send-email-bhupesh.sharma@freescale.com>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
 <1444891672-32117-13-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <6113441.JKoMX6G60g@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 12:17:52 Bhupesh Sharma wrote:
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 932001a..57b41c7 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -1,4 +1,4 @@
> -dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb fsl-ls2080a-rdb.dtb fsl-ls2080a-simu.dtb
>   
> 

Please use one line per dtb file here, for consistency with the other platforms

	Arnd
