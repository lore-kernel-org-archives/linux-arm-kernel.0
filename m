From: keescook@chromium.org (Kees Cook)
Date: Thu, 4 Jan 2018 10:32:46 -0800
Subject: [kernel-hardening] [PATCH] arm: Always use REFCOUNT_FULL
In-Reply-To: <20180104122801.GA3038@pjb1027-Latitude-E5410>
References: <20180104122801.GA3038@pjb1027-Latitude-E5410>
Message-ID: <CAGXu5j+YsB1FWvZHEjnixU8RMpk-DLDYLXXmxfQjsU_gy64ZDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 4:28 AM, Jinbum Park <jinb.park7@gmail.com> wrote:
> arm prefers to use REFCOUNT_FULL by default.
> This enables it for arm.
>
> Signed-off-by: Jinbum Park <jinb.park7@gmail.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3d349b4..ec80270 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -100,6 +100,7 @@ config ARM
>         select OLD_SIGACTION
>         select OLD_SIGSUSPEND3
>         select PERF_USE_VMALLOC
> +       select REFCOUNT_FULL
>         select RTC_LIB
>         select SYS_SUPPORTS_APM_EMULATION
>         # Above selects are sorted alphabetically; please add new ones
> --
> 1.9.1
>



-- 
Kees Cook
Pixel Security
