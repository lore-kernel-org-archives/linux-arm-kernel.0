From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 19:02:03 +0200
Subject: [PATCH] ARM: dts: Add STM32429i-EVAL board support
In-Reply-To: <1436693957-30855-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1436693957-30855-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <55AFCC8B.4090209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/12/2015 11:39 AM, Maxime Coquelin wrote:
> Main features of STM32429i-EVAL evaluation kit are:
>   - STM32F429 Cortex-M4 MCU @180MHz
>     * 2MB internal Flash
>     * 256KB internal RAM
>   - 32MB SDRAM
>   - 16MB NOR Flash
>   - 2MB SRAM
>   - 4.3" TFT LCD with resistive touchscreen
>   - SDCard connector (SDIO compatible)
>   - 1x USB 2.0 OTG + 1x USB 1.1 OTG
>   - Ethernet
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>   arch/arm/boot/dts/Makefile           |  4 +-
>   arch/arm/boot/dts/stm32429i-eval.dts | 75 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 78 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/stm32429i-eval.dts
>
>
Applied to next/dt-for-v4.3.

Best regards,
Maxime
