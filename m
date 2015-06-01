From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 17:56:51 +0200
Subject: [PATCH] ARM: Kconfig: Select clocksource in STM32 entry
In-Reply-To: <556971CC.2060102@gmail.com>
References: <1432331452-2350-1-git-send-email-mcoquelin.stm32@gmail.com>
 <5569714A.2010706@gmail.com> <556971CC.2060102@gmail.com>
Message-ID: <3983380.l9mqkIf3Dm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 May 2015 10:16:12 Maxime Coquelin wrote:
> With Daniel's valid address.
> 
> On 05/30/2015 10:14 AM, Maxime Coquelin wrote:
> > Hi Arnd,
> >
> > On 05/22/2015 11:50 PM, Maxime Coquelin wrote:
> >> STM32 clocksource driver needs to be selected if ARCH_STM32.
> >>
> >> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> >> ---
> >> Hi Arnd,
> >>
> >>    This patch applies on top of arm-soc's next/soc branch, so that 
> >> you don't
> >> get conflicts with Stefan's ARM_SINGLE_ARMV7M patch.Hi
> >>
> 

Applied to next/soc, thanks!

	Arnd
