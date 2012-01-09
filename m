From: B04825@freescale.com (Tabi Timur-B04825)
Date: Mon, 9 Jan 2012 23:24:42 +0000
Subject: [PATCH v2 09/10] arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
In-Reply-To: <1323439361-1647-10-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-10-git-send-email-b-cousson@ti.com>
Message-ID: <CAOZdJXU9w1O69ZgNEmgUZfezXEyn1JTyZxgmmLXAb3-mtJLnOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 8:02 AM, Benoit Cousson <b-cousson@ti.com> wrote:
>
> + ? ? ? eeprom at 50 {
> + ? ? ? ? ? ? ? compatible = "ti,eeprom";
> + ? ? ? ? ? ? ? reg = <0x50>;
> + ? ? ? };

Why is this "ti,"?  For EDID, isn't the I2C device actually on the
monitor itself, and DVI cable just connects to the I2C bus?

The reason I ask is that I'm trying to do the same thing for a PowerPC
board.  I need to defined an EDID I2C node.

-- 
Timur Tabi
Linux kernel developer at Freescale
