From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 12:55:52 +0200
Subject: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <555B098A.8030202@linaro.org>
 <CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>
Message-ID: <6177628.0ZDPLeVyah@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 12:02:59 Maxime Coquelin wrote:
> >
> > config CLKSRC_STM32
> >         bool
> >         select CLKSRC_MMIO
> >
> > and in the arch/arm/mach-stm32/Kconfig add select CLKSRC_STM32
> 
> Ok, I will send a patch for arch/arm/Kconfig, as Arnd already applied
> the one intruducing ARCH_STM32.
> 
> 

Please also make it possible to select this driver on other architectures
with COMPILE_TEST, so we get coverage from all the x86 test infrastructure.

	Arnd
