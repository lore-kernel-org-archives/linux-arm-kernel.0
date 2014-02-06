From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Feb 2014 10:21:48 -0500
Subject: [PATCH 3/4] DT: i2c: Trivial: Add sii,s35390a
In-Reply-To: <1391634309-3123-4-git-send-email-andrew@lunn.ch>
References: <1391634309-3123-1-git-send-email-andrew@lunn.ch>
 <1391634309-3123-4-git-send-email-andrew@lunn.ch>
Message-ID: <20140206152148.GC8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


+ devicetree ML, DT maintainers

On Wed, Feb 05, 2014 at 10:05:08PM +0100, Andrew Lunn wrote:
> Add the Seiko Instruments Inc S35390a to the list of trivial i2c
> devices.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 1a1ac2e560e9..e11ed0fe770c 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -58,6 +58,7 @@ plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
>  ramtron,24c64		i2c serial eeprom  (24cxx)
>  ricoh,rs5c372a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>  samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
> +sii,s35390a		2-wire CMOS real-time clock
>  st-micro,24c256		i2c serial eeprom  (24cxx)
>  stm,m41t00		Serial Access TIMEKEEPER
>  stm,m41t62		Serial real-time clock (RTC) with alarm
> -- 
> 1.7.10.4
> 
