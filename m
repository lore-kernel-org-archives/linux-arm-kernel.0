From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 17:53:12 +0200
Subject: [GIT PULL 2/3] DaVinci dts updates for v4.9
In-Reply-To: <20160824110006.1866-2-nsekhar@ti.com>
References: <20160824110006.1866-1-nsekhar@ti.com>
 <20160824110006.1866-2-nsekhar@ti.com>
Message-ID: <3347114.RAnckMhlMa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 24, 2016 4:30:05 PM CEST Sekhar Nori wrote:
> DaVinci DA850 device-tree enhancements include:
> 
> - Support for new board OMAP-L138 LCDK
> - Add AEMIF node on DA850 EVM and use it for NAND
> - Audio support for LCDK
> - Cleanups for PWM and UART
> 
> 

This one fails to build:


ERROR (phandle_references): Reference to non-existent node or label "nand_cs3_pins"

ERROR: Input tree has errors, aborting (use -f to force output)
  DTC     arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb


Can you send a fixed version please?

	Arnd
