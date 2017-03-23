From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Mar 2017 14:00:20 -0700
Subject: [PATCH 0/2] ARM: dts: am335x-icev2: Add support for W25Q64 NOR
 flash
In-Reply-To: <20170307215751.29266-1-fcooper@ti.com>
References: <20170307215751.29266-1-fcooper@ti.com>
Message-ID: <20170323210018.GS10760@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Franklin S Cooper Jr <fcooper@ti.com> [170307 14:01]:
> This patch set adds support for the on board SPI NOR flash on TI's AM335x
> Industrial Communication Engine rev 2.x board.
> 
> Franklin S Cooper Jr (1):
>   ARM: dts: am335x-icev2: Add SPI based NOR
> 
> Sekhar Nori (1):
>   doc: dt: mtd: add w25q64 to list of supported SPI flashes

Applying both into omap-for-v4.12/dt-v2 branch.

Thanks,

Tony
