From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 9 Sep 2018 10:00:23 +0800
Subject: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180906101516.GA5360@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
 <20180827014815.GD29208@dragon>
 <20180906101516.GA5360@sirena.org.uk>
Message-ID: <20180909020021.GA18838@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 11:15:17AM +0100, Mark Brown wrote:
> On Mon, Aug 27, 2018 at 09:48:16AM +0800, Shawn Guo wrote:
> 
> > Can you ACK on those two regulator patches, so that I can queue this
> > series up on IMX tree?
> 
> I was expecting to get a pull request with the precursor patches in it -
> the regulator driver seems to get a moderate amount of development so
> there's a reasonable risk of conflicts.

What about you create a stable topic branch for regulator patches and I
pull it into IMX tree?

Shawn
