From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:36:56 +0200
Subject: [RESEND PATCH v5 07/16] ARM: dts: koelsch: Add generic
 compatible string for I2C EEPROM
In-Reply-To: <20170615185418.13980-8-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170615185418.13980-8-javier@dowhile0.org>
Message-ID: <20170616133653.GB26834@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 08:54:09PM +0200, Javier Martinez Canillas wrote:
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up in the renesas tree for v4.14. 
