From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 15 May 2017 11:32:57 +0200
Subject: [PATCH v3 05/21] ARM: dts: at91: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170414010445.21727-6-javier@osg.samsung.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
 <20170414010445.21727-6-javier@osg.samsung.com>
Message-ID: <20170515093257.ge67swobfgi76nou@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/2017 at 22:04:29 -0300, Javier Martinez Canillas wrote:
> The at24 driver allows to register I2C EEPROM chips using different vendor
> and devices, but the I2C subsystem does not take the vendor into account
> when matching using the I2C table since it only has device entries.
> 
> But when matching using an OF table, both the vendor and device has to be
> taken into account so the driver defines only a set of compatible strings
> using the "atmel" vendor as a generic fallback for compatible I2C devices.
> 
> So add this generic fallback to the device node compatible string to make
> the device to match the driver using the OF device ID table.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Peter Rosin <peda@axentia.se>
> 
> ---
> 
> Changes in v3:
> - Add Peter Rosin acked-by tag.
> 
> Changes in v2: None
> 
>  arch/arm/boot/dts/at91-linea.dtsi   | 2 +-
>  arch/arm/boot/dts/at91-tse850-3.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
