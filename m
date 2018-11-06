From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Nov 2018 15:24:33 +0100
Subject: [PATCH] arm/crypto/aes-ce-glue.c: Remove duplicate header
In-Reply-To: <20181106121614.GA1985@hp-pavilion-15-notebook-pc-brajeswar>
References: <20181106121614.GA1985@hp-pavilion-15-notebook-pc-brajeswar>
Message-ID: <CAKv+Gu-2-DkVCOzVb_dRqr=nfiaPuec5XQT9V7z3RxuBdd-k9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2018 at 13:16, Brajeswar Ghosh <brajeswar.linux@gmail.com> wrote:
> Remove asm/hwcap.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/crypto/aes-ce-glue.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/crypto/aes-ce-glue.c b/arch/arm/crypto/aes-ce-glue.c
> index d0a9cec73707..5affb8482379 100644
> --- a/arch/arm/crypto/aes-ce-glue.c
> +++ b/arch/arm/crypto/aes-ce-glue.c
> @@ -10,7 +10,6 @@
>
>  #include <asm/hwcap.h>
>  #include <asm/neon.h>
> -#include <asm/hwcap.h>
>  #include <crypto/aes.h>
>  #include <crypto/internal/simd.h>
>  #include <crypto/internal/skcipher.h>
> --
> 2.17.1
>
