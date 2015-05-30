From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 30 May 2015 11:38:47 +0200
Subject: [PATCH v2 4/4] ARM: dts: stm32f429: Adopt STM32F4 clock driver
In-Reply-To: <1432972448-10332-5-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1432972448-10332-1-git-send-email-daniel.thompson@linaro.org>
 <1432972448-10332-5-git-send-email-daniel.thompson@linaro.org>
Message-ID: <55698527.1050504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/30/2015 09:54 AM, Daniel Thompson wrote:
> New bindings and driver have been created for STM32F42xxx series parts.
> This patch integrates these changes.
>
> Note: Earlier device tree blobs (those without st,stm32f42xxx
>        compatibles for the rcc) could still be used to boot basic
>        systems. Such systems rely on the bootloader to configure the
>        clock gates for vital periperhals.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>   arch/arm/boot/dts/stm32f429-disco.dts |  4 ++
>   arch/arm/boot/dts/stm32f429.dtsi      | 79 +++++++++++------------------------
>   2 files changed, 28 insertions(+), 55 deletions(-)
>
>
Reviewed-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks!
Maxime
