From: edubezval@gmail.com (Eduardo Valentin)
Date: Sat, 1 Apr 2017 09:15:12 -0700
Subject: [PATCH RFC 2/3] thermal: dove: convert to a thermal OF sensor
 device
In-Reply-To: <E1cn8qH-0002v6-SE@rmk-PC.armlinux.org.uk>
References: <E1cn8qH-0002v6-SE@rmk-PC.armlinux.org.uk>
Message-ID: <20170401161510.GA18500@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sun, Mar 12, 2017 at 07:07:45PM +0000, Russell King wrote:
> Convert the dove thermal infrastructure to an OF sensor device, and add
> the thermal zones for the SoC, with a critical trip point of 120?C.
> This allows us to specify thermal zones and couple them to cooling
> devices in DT.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/boot/dts/dove.dtsi    | 17 +++++++++++++++++
>  drivers/thermal/dove_thermal.c | 33 +++++++++++++++++++++++++--------

I have no opposition to these changes. The only request, to avoid
conflicts, is to split the patch into driver and DTS changes. We have
been pushing these separately. DTS changes go via the arch tree. Drivers
changes goes via Rui/me.

You can add my:
Acked-by: Eduardo Valentin <edubezval@gmail.com>

On the DTSI patch.
