From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 15:52:09 -0700
Subject: [PATCH RESEND] ARM: Kconfig: Select clocksource in STM32 entry
In-Reply-To: <1433668113-10389-1-git-send-email-mcoquelin.stm32@gmail.com>
 (Maxime Coquelin's message of "Sun, 7 Jun 2015 11:08:33 +0200")
References: <1433668113-10389-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <7hpp53jhwm.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Coquelin <mcoquelin.stm32@gmail.com> writes:

> STM32 clocksource driver needs to be selected if ARCH_STM32.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
> Hi Arnd,
>
>   This patch applies on top of arm-soc's next/soc branch, so that you don't 
> get conflicts with Stefan's ARM_SINGLE_ARMV7M patch.

Applied to next/soc,

Thanks,

Kevin
