From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 00:34:31 +0200
Subject: [GIT PULL] RealView Device Tree support for v3.18
In-Reply-To: <CACRpkdbHcJgnXDxO=yjuqbppT6OSR=N=4T80FFsrwKNM9Dy=sA@mail.gmail.com>
References: <CACRpkdbHcJgnXDxO=yjuqbppT6OSR=N=4T80FFsrwKNM9Dy=sA@mail.gmail.com>
Message-ID: <201409260034.31884.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 September 2014, Linus Walleij wrote:
> Linus Walleij (6):
>       leds: add a driver for syscon-based LEDs
>       leds: add device tree bindings for register bit LEDs
>       power: reset: driver for the Versatile syscon reboot
>       soc: add driver for the ARM RealView
>       ARM: l2c: parse cache properties from ePAPR definitions
>       ARM: realview: basic device tree implementation
> 

These really shouldn't be all in one branch, and the last one should
be split into the dts and the platform changes.

I've cherry-picked the first four patches into the next/drivers
branch, so no need to send them again.

Please split up the last patch in two and put the l2c changes
into Russell's patch tracker and add my 'Reviewed-by: 
Arnd Bergmann <arnd@arndb.de>'.

	Arnd
