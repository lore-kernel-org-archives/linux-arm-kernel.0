From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 6 Jul 2015 08:56:15 +0200
Subject: [PATCH] crypto: arm: ignore generated SHA2 assembly files
In-Reply-To: <e9fad4b90e8d3aac883e2a5ac99b330653bcc354.1436155417.git.baruch@tkos.co.il>
References: <e9fad4b90e8d3aac883e2a5ac99b330653bcc354.1436155417.git.baruch@tkos.co.il>
Message-ID: <CAKv+Gu_CN1pH-4uEk0x6kScAvo_hBY-bZMcCeZNpKADYWGQFQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 July 2015 at 06:03, Baruch Siach <baruch@tkos.co.il> wrote:
> These files are generated since commits f2f770d74a8d (crypto: arm/sha256 - Add
> optimized SHA-256/224, 2015-04-03) and c80ae7ca3726 (crypto: arm/sha512 -
> accelerated SHA-512 using ARM generic ASM and NEON, 2015-05-08).
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/crypto/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/crypto/.gitignore b/arch/arm/crypto/.gitignore
> index 6231d36b3635..31e1f538df7d 100644
> --- a/arch/arm/crypto/.gitignore
> +++ b/arch/arm/crypto/.gitignore
> @@ -1 +1,3 @@
>  aesbs-core.S
> +sha256-core.S
> +sha512-core.S
> --
> 2.1.4
>
