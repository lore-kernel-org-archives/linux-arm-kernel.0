From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Jan 2011 08:37:37 +0100
Subject: [PATCH 1/2] Updated XCEP partition sizes
In-Reply-To: <AANLkTinLTuJY9vDH_oHeKk7j6oo4369cF35PG+fVc5A_@mail.gmail.com>
References: <AANLkTi=42n+h+0buU_83R-y4XkXqy8bkWSquwuLAY56m@mail.gmail.com>
	<AANLkTimMniHC==y6majqBGKNBa91J1DpVK8zbnDxEWvy@mail.gmail.com>
	<AANLkTinLTuJY9vDH_oHeKk7j6oo4369cF35PG+fVc5A_@mail.gmail.com>
Message-ID: <20110126073737.GF22005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 05:19:55AM +0800, Eric Miao wrote:
> On Tue, Jan 25, 2011 at 2:54 AM, Matej Kenda <matejken@gmail.com> wrote:
> > Hi Eric,
> >
> > I've sent two simple patches for Iskratel XCEP last week.
> >
> > Can they be included in the kernel?
> 
> I'm a bit tentative on this. Patch 1 is basically OK, but what if
> someone needs a even larger partition in the future?  And some work
> is on-going with cleanup of those defconfigs, guess I'll hold a
> while those changes to the defconfig until that's clear enough.
> 
> BTW - did you run Uwe's script to make sure the changes to defconfig
> is the smallest one?
there is no "Uwe's script" anymore.  Just run

	make ARCH=arm savedefconfig

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
