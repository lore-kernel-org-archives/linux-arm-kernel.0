From: keescook@chromium.org (Kees Cook)
Date: Wed, 9 Apr 2014 11:14:19 -0700
Subject: [RFC PATCH 2/3] ARM: Kconfig: remove dependence of
 CONFIG_DEBUG_RODATA on !kexec
In-Reply-To: <1397062238-10515-3-git-send-email-Nikolay.Borisov@arm.com>
References: <1397062238-10515-1-git-send-email-Nikolay.Borisov@arm.com>
 <1397062238-10515-3-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <CAGXu5jLoZTYtHAZCzvxFr2MKG3F9F9MX=AJE4_9FNjms146SFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 9:50 AM, Nikolay Borisov <Nikolay.Borisov@arm.com> wrote:
>
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> ---
>  arch/arm/mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 3c7adea..ed58326 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -970,7 +970,7 @@ config ARM_KERNMEM_PERMS
>
>  config DEBUG_RODATA
>         bool "Make kernel text and rodata read-only"
> -       depends on ARM_KERNMEM_PERMS && KEXEC=n && KPROBES=n
> +       depends on ARM_KERNMEM_PERMS && KPROBES=n
>         default y
>         help
>           If this is set, kernel text and rodata will be made read-only.
> --
> 1.8.1.5
>
>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
Chrome OS Security
