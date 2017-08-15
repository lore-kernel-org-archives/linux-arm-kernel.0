From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Aug 2017 14:19:39 +0100
Subject: [PATCH] arm64: defconfig: add recently added crypto drivers as
 modules
In-Reply-To: <20170716195152.11285-1-ard.biesheuvel@linaro.org>
References: <20170716195152.11285-1-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9Omd52Av460EJO_4+BVgRmwqdF3Z2QS_PvAzJdomf=Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 July 2017 at 20:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Add the arm64 crypto drivers that have been added over the past
> couple of kernel releases to its defconfig as modules.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6c7d147eed54..3028bc0796ea 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -562,8 +562,17 @@ CONFIG_SECURITY=y
>  CONFIG_CRYPTO_ECHAINIV=y
>  CONFIG_CRYPTO_ANSI_CPRNG=y
>  CONFIG_ARM64_CRYPTO=y
> +CONFIG_CRYPTO_SHA256_ARM64=m
> +CONFIG_CRYPTO_SHA512_ARM64=m
>  CONFIG_CRYPTO_SHA1_ARM64_CE=y
>  CONFIG_CRYPTO_SHA2_ARM64_CE=y
>  CONFIG_CRYPTO_GHASH_ARM64_CE=y
> +CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=m
> +CONFIG_CRYPTO_CRC32_ARM64_CE=m
> +CONFIG_CRYPTO_AES_ARM64=m
> +CONFIG_CRYPTO_AES_ARM64_CE=m
>  CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
>  CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
> +CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m
> +CONFIG_CRYPTO_CHACHA20_NEON=m
> +CONFIG_CRYPTO_AES_ARM64_BS=m
> --
> 2.11.0
>

Ping?
