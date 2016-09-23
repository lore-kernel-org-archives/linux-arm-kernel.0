From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Sep 2016 16:22:25 +0200
Subject: [GIT PULL] few minor fixes for omap dts files for v4.9 merge
 window
In-Reply-To: <20160921224907.l2nxg5ynw3rxztlm@atomide.com>
References: <20160921224907.l2nxg5ynw3rxztlm@atomide.com>
Message-ID: <56736591.iYLCFQGX3V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 21, 2016 3:49:08 PM CEST Tony Lindgren wrote:
> Few fixes for omap dts files for v4.9 merge window. Let's also add
> the tilcdc quirks:
> 
> - Fix typo with recent beagleboard-x15 changes for mmc2_pins_default
> 
> - Add am335x blue-and-red-wiring quirk as specified in the binding in
>   Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt. Also
>   fix up the whitespace formatting for am335x-evmsk.
> 
> - Fix for recent igepv5 power button for GPIO_ACTIVE_LOW. Also fix
>   up the whitespace formatting for the button
> 

Pulled into next/dt, thanks!

	Arnd
