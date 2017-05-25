From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 15:33:08 +0800
Subject: [PATCH v5 14/20] arm64: dts: ls1043a: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <20170523133448.4794-15-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
 <20170523133448.4794-15-javier@dowhile0.org>
Message-ID: <20170525073304.GX26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 03:34:42PM +0200, Javier Martinez Canillas wrote:
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
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

Applied, thanks.
