From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 18:28:24 +0200
Subject: [GIT PULL] omap-gpmc changes for v4.9 merge window
In-Reply-To: <16b618d9-735f-f20c-7966-6e3d23b6b44e@ti.com>
References: <16b618d9-735f-f20c-7966-6e3d23b6b44e@ti.com>
Message-ID: <64181757.1UAW2kMoRa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 29, 2016 11:30:34 AM CEST Roger Quadros wrote:
> OMAP-GPMC: driver updates for v4.9
> 
> * Fix potential build failure if CONFIG_OMAP_GPMC is disabled while
>   OMAP_NAND driver is enabled
> * Trivial fixes which fix build warnings and code check tool warnings
>   (Coccinelle)
> * Use devm_gpiochip_add_data()
> 

Pulled into next/drivers, thanks!

	Arnd
