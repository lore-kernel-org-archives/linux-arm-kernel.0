From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 11:15:10 -0500
Subject: [PATCH V4 03/11] ARM: Kirkwood: topkick: Enable i2c bus.
In-Reply-To: <01661ac5cc55bb4f6e7ae3ca19f799f64cbe7ff5.1359232975.git.jason@lakedaemon.net>
References: <cover.1359232975.git.jason@lakedaemon.net>
 <01661ac5cc55bb4f6e7ae3ca19f799f64cbe7ff5.1359232975.git.jason@lakedaemon.net>
Message-ID: <20130216161510.GX14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 08:50:12PM +0000, Jason Cooper wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Add a DT node for I2C and pinctrl hog for the pins. There appears to
> be an i2c bus on topkick with a device on it:
> 
> i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- 64 -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/boot/dts/kirkwood-topkick.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied to mvebu/dt

thx,

Jason.
