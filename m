From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Mar 2015 15:04:10 +0100
Subject: linux-next: manual merge of the arm64 tree with the arm-soc tree
In-Reply-To: <20150331102122.34db1c6e@canb.auug.org.au>
References: <20150331102122.34db1c6e@canb.auug.org.au>
Message-ID: <20150331140407.GA23192@MBP>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Mar 31, 2015 at 10:21:22AM +1100, Stephen Rothwell wrote:
> diff --cc arch/arm64/configs/defconfig
> index f3c8619f8fe1,e07896c819ef..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -31,9 -31,12 +31,13 @@@ CONFIG_MODULES=
>   CONFIG_MODULE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
>   # CONFIG_IOSCHED_DEADLINE is not set
> + CONFIG_ARCH_EXYNOS7=y
>   CONFIG_ARCH_FSL_LS2085A=y
>   CONFIG_ARCH_MEDIATEK=y
>  +CONFIG_ARCH_SPRD=y
> + CONFIG_ARCH_SEATTLE=y
> + CONFIG_ARCH_TEGRA=y
> + CONFIG_ARCH_TEGRA_132_SOC=y
>   CONFIG_ARCH_THUNDER=y
>   CONFIG_ARCH_VEXPRESS=y
>   CONFIG_ARCH_XGENE=y

Thanks. Looks fine.

-- 
Catalin
