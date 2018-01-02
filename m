From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 2 Jan 2018 19:05:38 +0100 (CET)
Subject: [PATCH 0/4] gpio: driver for the RPi3 GPIO expander
In-Reply-To: <cover.1514898134.git.baruch@tkos.co.il>
References: <cover.1514898134.git.baruch@tkos.co.il>
Message-ID: <1090269396.181215.1514916338795@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 2. Januar 2018 um 14:19 geschrieben:
> 
> 
> The Raspberry Pi 3 has a GPIO expander that controls, among others, the 
> activity LED, and the camera connector GPIOs. The GPIO expander on an I2C bus 
> that is not directly controlled from the ARM core. The VC4 firmware controls 
> the I2C bus, and allows the ARM core to set/get GPIO settings over its mailbox 
> interface.
> 
> This series adds support for the RPi3 expander.
> 
> The driver is ported from the downstream kernel at 
> https://github.com/raspberrypi/linux/, branch rpi-4.9.y.
> 

thanks for trying to upstream this. There has been attemps by Eric Anholt (September 2016) and Michael Zoran (March 2017). Some problems like get_direction() has been fixed, but not all of them.

So please look at the followings links first:
https://patchwork.kernel.org/patch/9339859/
https://patchwork.kernel.org/patch/9339857/
http://lists.infradead.org/pipermail/linux-rpi-kernel/2017-March/005903.html

Stefan
