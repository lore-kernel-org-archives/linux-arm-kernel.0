From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Sep 2017 15:44:17 -0700
Subject: [PATCH] arm64: Always use REFCOUNT_FULL
In-Reply-To: <20170920204959.GA79741@beast>
References: <20170920204959.GA79741@beast>
Message-ID: <CAKv+Gu-hrxCQdfVSKyUXG_ZXhnseKMuaGU=VamrHa9NXvDSgvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 September 2017 at 13:49, Kees Cook <keescook@chromium.org> wrote:
> As discussed at the Linux Security Summit, arm64 prefers to use
> REFCOUNT_FULL by default. This enables it for the architecture.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: hw.likun at huawei.com
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0df64a6a56d4..9fe7a7f4c94c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -119,6 +119,7 @@ config ARM64
>         select PCI_ECAM if ACPI
>         select POWER_RESET
>         select POWER_SUPPLY
> +       select REFCOUNT_FULL
>         select SPARSE_IRQ
>         select SYSCTL_EXCEPTION_TRACE
>         select THREAD_INFO_IN_TASK
> --
> 2.7.4
>
>
> --
> Kees Cook
> Pixel Security
