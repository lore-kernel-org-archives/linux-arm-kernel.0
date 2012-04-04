From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2012 12:50:32 +0000
Subject: [PATCH v2 1/3] PATA host controller driver for ep93xx
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409EBF@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <201204032008.00509.arnd@arndb.de>
 <ADE657CA350FB648AAC2C43247A983F0020698409EBF@AUSP01VMBX24.collaborationhost.net>
Message-ID: <201204041250.32344.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, H Hartley Sweeten wrote:
> The SYSCON stuff is not exposed outside of the arch specific mach-ep93xx
> directory. I would prefer this stay like it is for now. If/when ep93xx gets
> converted to device tree we can address this.

Ok, fair enough.

> I have been looking over the drivers/pinctrl stuff to see if it's worth creating
> a pinctrl-ep93xx.c driver. If I end up doing one, the function above could
> probably be replaced with something from the pin mux api.

Yes, that sounds like a good long-term plan.

	Arnd
