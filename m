From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 May 2014 15:54:29 +0200
Subject: [Patch v5 0/7] Introduce keystone reset driver
In-Reply-To: <537E011B.9090902@ti.com>
References: <1400766516-14537-1-git-send-email-ivan.khoronzhuk@ti.com>
 <537E011B.9090902@ti.com>
Message-ID: <5069120.YZWxxyxdrl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014 09:52:27 Santosh Shilimkar wrote:
> On Thursday 22 May 2014 09:48 AM, Ivan Khoronzhuk wrote:
> > These patches introduce keystone reset driver.
> > 
> > The keystone SoC can be rebooted in several ways. By external reset
> > pin, by soft and by watchdogs. This driver allows software reset and reset
> > by one of the watchdogs. Also added opportunity to set soft/hard reset type.
> > 
> > Based on linux-next/master
> > 
> > v5..v4
> >   power: reset: keystone-reset: introduce keystone reset driver
> >       - changed to get rsmux and rspll offsets from DT
> >   clock: keystone-pllctrl: add bindings for keystone pll controller
> >       - new patch
> >   mfd: ti-keystone-devctrl: add bindings for device state control
> >       - new patch
> >   power: reset: add bindings for keystone reset driver
> >       - corrected description of "ti,syscon-pll", "ti,syscon-dev" properties
> >       - corrected examples
> >   ARM: dts: keystone: update reset node to work with reset driver
> >       - added nodes for pll-controller and device-state-controll
> >       - added offsets to "ti,syscon-pll", "ti,syscon-dev" properties
> >
> Looks like you haven't collected Arnd's Reviewed-by tag on the patches.
> Can be added later as well while applying.
> 
> 

I was going to comment the same. Anyway here you have it for the remaining
patches:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
