From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Apr 2017 07:17:35 -0700
Subject: [PATCH v3 03/21] ARM: dts: omap: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170414010445.21727-4-javier@osg.samsung.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
 <20170414010445.21727-4-javier@osg.samsung.com>
Message-ID: <20170414141734.GR5339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@osg.samsung.com> [170413 18:08]:
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

Looks good to me assuming this will get merged in a single series:

Acked-by: Tony Lindgren <tony@atomide.com>

Or if you want me to pick this patch separately, let me know.

Regards,

Tony
