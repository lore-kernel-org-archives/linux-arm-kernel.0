From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 23:21:06 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <1431158038-3813-15-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-15-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <2789447.8FUTAOJOHR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 May 2015 09:53:56 Maxime Coquelin wrote:
> +#include  <dt-bindings/mfd/stm32f4-rcc.h>
> +
> 

Can you find a way to avoid this dependency?

Maybe you can change the bindings so that the numbers you pass as
arguments to the reset and clock specifiers reflect the numbers that
the hardware use?

	Arnd
