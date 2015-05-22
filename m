From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 22 May 2015 15:06:21 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <1432161344-1930-1-git-send-email-stefan@agner.ch>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
Message-ID: <CALszF6Cc6WQoA1jKxb9nLgg1108bM4z0tTZRejZEfxS4R_JoGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-21 0:35 GMT+02:00 Stefan Agner <stefan@agner.ch>:
> Use the new config symbol ARM_SINGLE_ARMV7M which groups config
> symbols used by modern ARMv7-M platforms. This allows supporting
> multiple ARMv7-M platforms in one kernel image. However, a common
> kernel image requires the combined platforms to share the same
> main memory layout to be bootable.
>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Since this is essentially only a shift of config symbols, it
> should not change runtime behavior, at least when selecting
> only one platform.
>
> Uwe, this is essentially the same I had in my patchset, just
> converting the other platforms too. I was bold and added your
> Ack anyway...
>
> Joachim, Maxime, I test compiled with your defconfigs, compiled
> fine on my machine.
>
>  arch/arm/Kconfig       | 86 ++++++++++++++++++--------------------------------
>  arch/arm/Kconfig.debug |  5 ++-
>  2 files changed, 32 insertions(+), 59 deletions(-)
>

For the stm32 part:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
