From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jun 2012 14:32:23 +0000
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <20120628114616.GE28922@opensource.wolfsonmicro.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <201206281121.56769.arnd@arndb.de>
 <20120628114616.GE28922@opensource.wolfsonmicro.com>
Message-ID: <201206281432.24061.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 June 2012, Mark Brown wrote:
> Show Details
>   On Thu, Jun 28, 2012 at 11:21:56AM +0000, Arnd Bergmann wrote:
> 
> > What platform is this driver for?
> >  - If it's for an existing platform that does not have DT support, please
> >    include the platform changes for that platform so we can see what gets
> >    done in there.
> 
> This is really not normal practice for device drivers, it'd be a serious
> obstacle to getting drivers integrated if we have to have a board merged
> with every driver.

But it would be very helpful to see how the platform data is set, especially
with the callback. If the callback is just there to set up a regulator
or clock, then it should be changed to a more generic way.

	Arnd
