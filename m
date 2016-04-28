From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 17:49:49 +0200
Subject: NXP LPC32xx Defconfig Updates for v4.7
In-Reply-To: <5721553C.8050701@mleia.com>
References: <5721553C.8050701@mleia.com>
Message-ID: <14824422.IqGz1QqrzM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 03:11:40 Vladimir Zapolskiy wrote:
> NXP LPC32xx defconfig updates for v4.7
> 
> This includes savedefconfig update of lpc32xx_defconfig, which removes
> a number of outdated config options, plus ARM PrimeCell PL17x memory
> controller driver is enabled by default now, on LPC32xx boards the
> controller is commonly used to access SDRAM and NOR.
> 

Pulled into next/defconfig, thanks!

	Arnd
