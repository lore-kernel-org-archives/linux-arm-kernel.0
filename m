From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 15:13:06 -0700
Subject: [PATCH RESEND] MAINTAINERS: catch special Rockchip code locations
In-Reply-To: <3644024.F4LLe7dWA4@diego>
References: <3644024.F4LLe7dWA4@diego>
Message-ID: <20140827221306.GD13392@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 12:05:50AM +0200, Heiko St?bner wrote:
> Add some more locations that aren't catched by the general wildcard.
> This includes the devicetree files, clock directory, rk3x i2c driver,
> everything in a third layer under drivers like iio/adc/rockchip_saradc.c
> and the i2s driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Main reason behind this, is that I only accidentially stumbled over the
> clock api refactoring series [0] from Toneu Vizoso, wheras with the
> better matching it should've been automatic.
> 
> [0] https://lkml.org/lkml/2014/8/18/481

Applied for 3.17.


Thanks,

-Olof
