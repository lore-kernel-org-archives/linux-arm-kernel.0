From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 15:52:37 -0700
Subject: [PATCH RESEND v9] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <1433343242-1425-1-git-send-email-mcoquelin.stm32@gmail.com>
 (Maxime Coquelin's message of "Wed, 3 Jun 2015 16:54:02 +0200")
References: <1433343242-1425-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <7hlhfrjhvu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Coquelin <mcoquelin.stm32@gmail.com> writes:

> The STMicrolectornics's STM32F429 MCU has the following main features:
>  - Cortex-M4 core running up to @180MHz
>  - 2MB internal flash, 256KBytes internal RAM
>  - FMC controller to connect SDRAM, NOR and NAND memories
>  - SD/MMC/SDIO support
>  - Ethernet controller
>  - USB OTFG FS & HS controllers
>  - I2C, SPI, CAN busses support
>  - Several 16 & 32 bits general purpose timers
>  - Serial Audio interface
>  - LCD controller
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Applied to next/dt,

Thanks,

Kevin
