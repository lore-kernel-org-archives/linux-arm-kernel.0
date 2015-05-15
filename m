From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 17:39:57 +0200
Subject: RaspberryPi SoC (mach) changes due for v4.2
In-Reply-To: <20150514092543.GF22418@x1>
References: <20150514092543.GF22418@x1>
Message-ID: <3591304.HkmxZFlZfG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 May 2015 10:25:43 Lee Jones wrote:
> Eric Anholt (3):
>       ARM: bcm2835: Skip doing our own iotable_init() initialization
>       ARM: bcm2835: Drop the init_irq() hook
>       ARM: bcm2835: Move the restart/power_off handling to the WDT driver
> 
> 

Very nice!

Do you already know if the bcm2836 support will be ready in time for 4.2?

	Arnd
