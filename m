From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 22:01:12 +0100
Subject: [PATCH V2 0/4] clk: bcm2835: add additinal clocks and add frac
 support
In-Reply-To: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
References: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <7176182.NH1zi8JFMJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 January 2016 19:55:52 kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> The clk-bcm2835 driver right now relies on BCM2835_CLOCK_COUNT defined
> in include/dt-binding/clocks/bcm2835.h
> With every new clock introduced this value needs to increase,
> which is not what should happen for bindings.
> 
> So we reorganize the driver so that it is no longer necessary
> to define BCM2835_CLOCK_COUNT.
> 
> Also the driver calculates fractional clock dividers correctly,
> but it does not enable the bit to enable support in the register.
> As a minimal extension we now can also define higher order MASH
> support when defining the clocks.
> 
> Finally we add all the 23 different HW clocks that have not been
> configured in the driver.
> 
> 

Looks good to me, thanks for the update!

	Arnd
