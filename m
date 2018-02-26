From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 26 Feb 2018 14:30:02 +0100
Subject: [PATCH] MAINTAINERS: update entries for ARM/STM32
In-Reply-To: <1519650228-6271-1-git-send-email-alexandre.torgue@st.com>
References: <1519650228-6271-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <CALszF6D9cpiwnc9a+ZeOiED5Fgv1yLLxJrO7rH9fKttLja-jZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-26 14:03 GMT+01:00 Alexandre Torgue <alexandre.torgue@st.com>:
> Changes old git repository to the maintained one and adds more patterns.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bdc260..802b984 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1999,8 +1999,10 @@ M:       Maxime Coquelin <mcoquelin.stm32@gmail.com>
>  M:     Alexandre Torgue <alexandre.torgue@st.com>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
>  N:     stm32
> +F:     arch/arm/boot/dts/stm32*
> +F:     arch/arm/mach-stm32/
>  F:     drivers/clocksource/armv7m_systick.c
>
>  ARM/TANGO ARCHITECTURE
> --
> 2.7.4
>

Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks,
Maxime
