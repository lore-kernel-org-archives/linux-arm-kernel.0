From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 16:48:31 +0100
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <20150310142805.GN5264@atomide.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <2223973.a64rBcZvaA@wuerfel> <20150310142805.GN5264@atomide.com>
Message-ID: <2300824.dcEMS7aYJa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 07:28:05 Tony Lindgren wrote:
> 
> Oops I forgot about the omap3-sbc-t3730, so yes we have to keep the
> platform data a little bit longer. But nothing stopping us moving
> all the other ones to use a proper device tree based configuration.
> 

For all I can tell, the t3730 board file does not support wl12xx
at the moment, only the dts file does.

If we do what Sekhar suggested and drop wl12xx support from
the DA850 EVM board file, we can fix all wlcore users.

	Arnd
