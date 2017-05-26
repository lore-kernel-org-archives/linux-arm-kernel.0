From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 May 2017 08:51:09 -0700
Subject: [PATCH v5 03/20] ARM: dts: omap: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170523133448.4794-4-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
 <20170523133448.4794-4-javier@dowhile0.org>
Message-ID: <20170526155108.GF3717@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [170523 06:38]:
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

Picking this patch into omap-for-v4.13/dt thanks.

Tony
