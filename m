From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 7 Jul 2015 11:38:06 +0200
Subject: [PATCH v3 3/3] ARM: dts: stm32f429: Adopt STM32F4 clock driver
In-Reply-To: <1433966978-24422-4-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1433966978-24422-1-git-send-email-daniel.thompson@linaro.org>
 <1433966978-24422-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <CALszF6DF3QNDhCe6QQqgHbt5MH0z0eJ7TKXT-5i-9g1mfk6mQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

2015-06-10 22:09 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> New bindings and driver have been created for STM32F42xxx series parts.
> This patch integrates these changes.
>
> Note: Earlier device tree blobs (those without st,stm32f42xxx
>       compatibles for the rcc) could still be used to boot basic
>       systems. Such systems rely on the bootloader to configure the
>       clock gates for vital periperhals.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f429-disco.dts |  4 ++
>  arch/arm/boot/dts/stm32f429.dtsi      | 79 +++++++++++------------------------
>  2 files changed, 28 insertions(+), 55 deletions(-)
>

Patch applied to next/dt-for-v4.3 of stm32 tree.

Thanks!
Maxime
