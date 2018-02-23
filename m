From: ylhuajnu@outlook.com (Yao Lihua)
Date: Fri, 23 Feb 2018 15:29:08 +0000
Subject: [PATCH] arm64: defconfig: enable R8A77965 SoC
In-Reply-To: <20180223085115.13782-1-horms+renesas@verge.net.au>
References: <20180223085115.13782-1-horms+renesas@verge.net.au>
Message-ID: <SN4PR0601MB3709B0D878715B944580EFCCC4CC0@SN4PR0601MB3709.namprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 23, 2018 04:51 PM, Simon Horman wrote:
> Enable the Renesas R-Car M3-W (R8A77965) SoC in the ARM64 defconfig.
R8A77965 should be M3-N?
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ceafd26f0fab..c8b59543f670 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -51,6 +51,7 @@ CONFIG_ARCH_SEATTLE=y
>   CONFIG_ARCH_RENESAS=y
>   CONFIG_ARCH_R8A7795=y
>   CONFIG_ARCH_R8A7796=y
> +CONFIG_ARCH_R8A77965=y
>   CONFIG_ARCH_R8A77970=y
>   CONFIG_ARCH_R8A77980=y
>   CONFIG_ARCH_R8A77995=y
