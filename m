From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 22:24:39 +0100
Subject: [GIT PULL] ARM: mediatek: soc updates for v4.5
In-Reply-To: <CABuKBeLEf+jyE5gzWEVzfRZ7DwRgnLrdWLREwqqfYGBb2g+exQ@mail.gmail.com>
References: <CABuKBeLEf+jyE5gzWEVzfRZ7DwRgnLrdWLREwqqfYGBb2g+exQ@mail.gmail.com>
Message-ID: <3414351.uxCDVXedab@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 February 2016 13:40:51 Matthias Brugger wrote:
> Fix state machine implemenation of PMIC wrapper.
> Add SMP support for mt7623.
> Disable watchdog of STAUPD in PMIC wrapper for mt8173.
> Add SMP support for mt2701.
> Use builtin_platform_driver for scpsys. Driver can't be build as module.
> Fix regulator enablement in scpsys.
> 
> 

Pulled into next/dt, thanks!

	Arnd
