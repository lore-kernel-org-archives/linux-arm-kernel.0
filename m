From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 21:49:17 +0100
Subject: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
In-Reply-To: <e6e0105f-3135-e5b7-8224-419c9f730a09@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <e6e0105f-3135-e5b7-8224-419c9f730a09@free.fr>
Message-ID: <85a73243-0c53-43e5-5002-90631c0a8c90@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Add interested parties ]

On 07/11/2018 21:18, Marc Gonzalez wrote:

> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
> which is not set.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8e181cca0a05..e4957df18f23 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -727,4 +727,3 @@ CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_PREEMPT is not set
>  # CONFIG_FTRACE is not set
>  CONFIG_MEMTEST=y
> -CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=y
> 
