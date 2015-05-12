From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 15:18:28 +0200
Subject: [PATCH 0/4] ARM: digicolor: dt and config updates
In-Reply-To: <cover.1430217994.git.baruch@tkos.co.il>
References: <cover.1430217994.git.baruch@tkos.co.il>
Message-ID: <201505121518.29053.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 April 2015, Baruch Siach wrote:
> This series enables a couple of digicolor SoC devices for which drives were
> added during the v4.1 cycle. Also, add a MAINTAINERS entry for digicolor, and
> enabled the platform in multi_v7_defconfig.
> 
> Based on v4.1-rc1.
> 
> Baruch Siach (4):
>   ARM: digicolor: enable CX92755 on-chip RTC device
>   ARM: digicolor: add i2c master controller support
>   MAINTAINERS: add Conexant Digicolor machines entry
>   ARM: multi_v7_defconfig: enable Conexant Digicolor platform

I've merged the first two patches into next/dt, the third patch into fixes
and the fourth patch into next/defconfig. Thanks!

I had not mentioned the maintainers change, but it's already part of 4.1-rc3
now.

	Arnd
