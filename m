From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 12:21:34 +0200
Subject: [PATCH] ARM: dt: sun6i: Add #address-cells and #size-cells to i2c
 controller nodes
In-Reply-To: <20140728093532.GA3952@lukather>
References: <1405954467-29331-1-git-send-email-wens@csie.org>
 <20140728093532.GA3952@lukather>
Message-ID: <16210485.QVpa35VqND@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 11:35:32 Maxime Ripard wrote:
> On Mon, Jul 21, 2014 at 10:54:27PM +0800, Chen-Yu Tsai wrote:
> > dtc was giving warnings for missing #address-cells and #size-cells for
> > the new sun6i-a31-hummingbird.dts, which has a i2c-based rtc device.
> > 
> > This patch adds the properties for all i2c controller nodes for sun6i.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> Applied, thanks.
> 
> I don't plan on sending more DT pull-request unless something big
> shows up, so it's probably queued for 3.18.
> 
> It's not like it's urgent anyway...
> 

No, please send this one, I don't want to introduce new warnings
in 3.17.

	Arnd
