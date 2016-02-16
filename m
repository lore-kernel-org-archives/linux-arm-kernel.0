From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 15:36:03 +0100
Subject: [PATCH 0/3] ARM: stm32: Introduce support for STM32F469
In-Reply-To: <1455632221-31834-1-git-send-email-lee.jones@linaro.org>
References: <1455632221-31834-1-git-send-email-lee.jones@linaro.org>
Message-ID: <8086636.p5SR2hZz49@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 14:16:58 Lee Jones wrote:
> Simple set using the STM32F429 infrastructure as a foundation.
> There will be more changes to the DTS files and a requirement for
> added hierarchical layering as more differences become apparent.
> 
> Lee Jones (3):
>   ARM: stm32: Supply a DTS file for the STM32F469 Discovery board
>   ARM: configs: Add new config fragment to change RAM start point
>   ARM: stm32: Identify a new board - STM32F469
> 

Looks good to me. It's the first use of Kconfig fragments we have on ARM,
but it seems justified.

Acked-by: Arnd Bergmann <arnd@arndb.de
