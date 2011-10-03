From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 11:22:56 +0200
Subject: [PATCH 00/30] ARM/omap: omap specific randconfig fixes
In-Reply-To: <4E894295.5000608@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<4E894295.5000608@ti.com>
Message-ID: <7246478.IyGHQ24uSq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 10:35:25 Santosh Shilimkar wrote:

> > The entire set is also available from
> >  git pull git://git.linaro.org/people/arnd/arm-soc.git randconfig/omap
> > 
> > but I have not yet pulled them into the for-next branch.
> > 
> Do you have any scripts to create these randconfigs ?
> These are useful to run on newer set of patches also to get all
> builds right first place.

Yes, see the for-next+randconfig branch of
git://git.linaro.org/people/arnd/arm-soc.git. It has all my patches
and a randconfig.sh script.

Right now, I'm trying to get a baseline upstream, since I have around 150
patches that are needed to always build ten platforms successfully.

The main problem is that you basically need all the patches I did in order
to find regressions, and some of the device driver patches are not currently
in a state where I could submit them. I hope that by the time of the 3.3
merge window, I have enough patches upstream that you no longer need to
pull in an extra tree.

Thanks a lot for your review of the omap set!

	Arnd
