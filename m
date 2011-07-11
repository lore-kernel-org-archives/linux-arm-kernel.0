From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 11 Jul 2011 15:01:06 +0400
Subject: [PATCH 11/51] ARM: Kconfig: Allow kprobes on Thumb-2 kernels
In-Reply-To: <1310209058-20980-12-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-12-git-send-email-tixy@yxit.co.uk>
Message-ID: <4E1AD7F2.9020205@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-07-2011 14:56, Tixy wrote:

> From: Jon Medhurst<tixy@yxit.co.uk>

> Signed-off-by: Jon Medhurst<tixy@yxit.co.uk>
> ---
>   arch/arm/Kconfig |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..b4177c5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -10,7 +10,7 @@ config ARM
>   	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
>   	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>   	select HAVE_ARCH_KGDB
> -	select HAVE_KPROBES if (!XIP_KERNEL&&  !THUMB2_KERNEL)
> +	select HAVE_KPROBES if (!XIP_KERNEL)

    Why not drop useless parens, while at it?

WBR, Sergei
