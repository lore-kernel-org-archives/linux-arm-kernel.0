From: tony@atomide.com (Tony Lindgren)
Date: Sun, 2 Mar 2014 09:43:37 -0800
Subject: [PATCH v2 0/7] ARM: dts: omap3-gta04: Various devicetree updates
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Message-ID: <20140302174336.GC18496@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [140301 06:02]:
> This updated series fix issue with proper gta04 booting in 3.14 kernel
> and add various devices to devicetree.
> 
> Changes from V1: 
> - removed fixes which was merged to 3.14 already
> - add bma180 accelerometer + booting fix
> 
> Marek Belisko (2):
>   ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid
>     problems with booting
>   ARM: dts: omap3-gta04: Add touchscreen properties
> 
> NeilBrown (5):
>   ARM: dts: omap3-gta04: Add support for magnetometer
>   ARM: dts: omap3-gta04: Add twl4030 charger
>   ARM: dts: omap3-gta04: Add basic sound support
>   ARM: dts: omap3-gta04: Enable mmc2 for wifi
>   ARM: dts: omap3-gta04: Add bma180 accelerometer
> 
>  arch/arm/boot/dts/omap3-gta04.dts | 53 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)

Thanks for updating these, I'll take the first one into
omap-for-v3.14/fixes and the rest into omap-for-v3.15/dt.

Regards,

Tony
