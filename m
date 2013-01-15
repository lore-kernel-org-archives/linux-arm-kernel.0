From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Jan 2013 14:46:53 +0000
Subject: [RFC PATCH 1/7] drivers: usb: phy: add a new driver for usb part
 of control module
In-Reply-To: <50F56697.9060803@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
 <201301151336.47546.arnd@arndb.de> <50F56697.9060803@ti.com>
Message-ID: <201301151446.53206.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 January 2013, kishon wrote:
> Good point :-). Currently, none of the OMAP platforms have multiple 
> control modules and it doesn't seem to be in the future (AFAIK). While 
> it might be simpler to support multiple control devices with phandle, it 
> might face the same complications as faced by the USB PHY framework for 
> non-dt boot.
> 

Maybe you can put the phandle into the binding then but don't use it
until hardware actually requires it. If anything needs it, then we
can always change the code later, but it's harder to change the
binding.

	Arnd
