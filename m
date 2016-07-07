From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 15:11:17 +0200
Subject: [GIT PULL] Amlogic SoC updates for v4.8 (#2)
In-Reply-To: <m28txeqt6v.fsf@baylibre.com>
References: <m28txeqt6v.fsf@baylibre.com>
Message-ID: <3439252.vVJRtn8n7i@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 6, 2016 3:48:24 PM CEST Kevin Hilman wrote:
> Amlogic SoC updates:
> - Kconfig updates for new GXBB clock driver
> 
> ----------------------------------------------------------------
> Michael Turquette (2):
>       arm: meson: explicitly select clk drivers
>       arm64: amlogic: select gxbb clk driver

Hmm, two patches that should go on two different branches...

I know it's silly to send send two pull requests here, if you like
I'll just cherry-pick them into next/soc and next/arm64 instead.

	Arnd
